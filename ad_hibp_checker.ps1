# This script requires elevated privileges (likely Domain Admin)

# Import the Active Directory module
Import-Module ActiveDirectory
Write-Host "AD Module imported"

# Import the DSInternals module
Remove-Module DSInternals -ErrorAction SilentlyContinue
Import-Module DSInternals -Force
Write-Host "DSInternals Module imported"

# Your HIBP API key
$apiKey = "your_api_key"

# Get all users in the domain (adjust the properties as needed)
$users = Get-ADUser -Filter * -Properties SamAccountName

# Get the domain controller
$dc = Get-ADDomainController
Write-Host "Found Domain Controller: $($dc.HostName)"

# Get the hashes using DSInternals
Write-Host "Attempting to get hashes..."
$hashes = Get-ADReplAccount -All -Server $dc.HostName |
    Select-Object SamAccountName, NTHash
Write-Host "Retrieved $($hashes.Count) account entries"

# Create a hashtable to store the hashes and associated users
$hashTable = @{}

# Iterate through the accounts and populate the hashtable
foreach ($account in $hashes) {
    if (-not [string]::IsNullOrEmpty($account.NTHash)) {
        $hash = [System.BitConverter]::ToString($account.NTHash).Replace("-", "")
        Write-Host "Found hash for $($account.SamAccountName): $hash" -ForegroundColor Cyan
        if ($hashTable.ContainsKey($hash)) {
            $hashTable[$hash] += ", " + $account.SamAccountName
        } else {
            $hashTable[$hash] = $account.SamAccountName
        }
    }
}
Write-Host "Processed $($hashTable.Count) unique hashes" -ForegroundColor Yellow

# Function to check a hash against HIBP with rate limiting and error handling
function Check-HIBP {
    param(
        [string]$hash,
        [string]$apiKey
    )

    # Check if the hash is valid before proceeding
    if ([string]::IsNullOrEmpty($hash) -or $hash.Length -lt 5) {
        Write-Warning "Invalid hash: $hash"
        return $false 
    }

    $hashPrefix = $hash.Substring(0, 5)
    $hashSuffix = $hash.Substring(5).ToUpper()
    $url = "https://api.pwnedpasswords.com/range/$hashPrefix" + "?mode=ntlm"

    try {
        Write-Host "Checking prefix: $hashPrefix, looking for suffix: $hashSuffix" -ForegroundColor DarkGray
        
        $response = Invoke-RestMethod -Uri $url -Method Get
        
        # Split the response into lines and check each one
        foreach ($line in $response -split "`r`n") {
            $parts = $line -split ":"
            if ($parts[0] -eq $hashSuffix) {
                Write-Host "Found match! This hash appears $($parts[1]) times in breaches" -ForegroundColor Red
                return $true
            }
        }
        
        return $false

    } catch {
        Write-Warning "Error checking hash against HIBP: $($_.Exception.Message)"
        Write-Warning "Response: $($_.Exception.Response.StatusCode.value__) $($_.Exception.Response.StatusDescription)"
        return $false
    }
}

# Counter for API calls
$apiCalls = 0
# Timestamp for the last API call
$lastAPICall = Get-Date

# Create a results array to store all findings
$results = @()

# Check each hash against HIBP with rate limiting
foreach ($hash in $hashTable.Keys) {
    Write-Host "`nChecking HIBP for hash: $hash" -ForegroundColor Cyan
    Write-Host "Associated user(s): $($hashTable[$hash])" -ForegroundColor Cyan
    
    if ($apiCalls -ge 10 -and (Get-Date) -lt ($lastAPICall + [TimeSpan]::FromMinutes(1))) {
        $secondsToWait = 60 - ((Get-Date) - $lastAPICall).Seconds
        Write-Host "Rate limit reached. Waiting for $secondsToWait seconds..." -ForegroundColor Yellow
        Start-Sleep -Seconds $secondsToWait
        $apiCalls = 0
    }

    $isCompromised = Check-HIBP -hash $hash -apiKey $apiKey
    
    # Create result object with only first 5 chars of hash
    $result = @{
        Timestamp = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
        HashPrefix = $hash.Substring(0, 5)
        Users = $hashTable[$hash]
        IsCompromised = $isCompromised
    }
    
    $results += $result

    if ($isCompromised) {
        Write-Host "COMPROMISED PASSWORD FOUND for user(s): $($hashTable[$hash])" -ForegroundColor Red
        Write-Host "Hash Prefix: $($hash.Substring(0, 5))..." -ForegroundColor Red
    } else {
        Write-Host "Password not found in HIBP for user(s): $($hashTable[$hash])" -ForegroundColor Green
    }

    $apiCalls++
    $lastAPICall = Get-Date
}

# Create output directory if it doesn't exist - change this if you want it output elsewhere
$outputPath = "C:\ProgramData\HIBPCheck"
if (-not (Test-Path $outputPath)) {
    New-Item -ItemType Directory -Path $outputPath -Force | Out-Null
}

# Save results to JSON file with timestamp
$timestamp = (Get-Date).ToString('yyyyMMdd_HHmmss')
$jsonFile = Join-Path $outputPath "hibp_results_$timestamp.json"
$results | ConvertTo-Json -Depth 10 | Out-File $jsonFile -Encoding UTF8

Write-Host "`nResults have been saved to: $jsonFile" -ForegroundColor Yellow
