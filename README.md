# ad_hibp_ntlm_check
Check NTLM hashes (first 5 characters) against HIBP hashes. Output into json format.

## setup
Modify the script to utilize your API key, and modify the output directory if required. You can also adjust the number of requests per minute to stay within your alotted limits.

## Output
```
[
    {
        "HashPrefix":  "14085",
        "Timestamp":  "2024-12-17 13:38:32",
        "Users":  "WEBSRV01$",
        "IsCompromised":  false
    },
    {
        "HashPrefix":  "FD45C",
        "Timestamp":  "2024-12-17 13:38:32",
        "Users":  "APPSRV03$",
        "IsCompromised":  false
    },
    {
        "HashPrefix":  "6DE00",
        "Timestamp":  "2024-12-17 13:38:32",
        "Users":  "caitlin.valerie, brandi.mary, craig.brent, leslie.brent, melanie.katie, william.stacy, amanda.mark, cody.derek, kristin.sheena, adrian.mark, nathan.donald, craig.patrick, rachel.benjamin, angela.cynthia, holly.thomas, karen.jason, kathleen.matthew, caitlin.stephen, tyler.julia, james.stephanie, george.courtney, michael.ashley, latoya.krystal, jason.kyle, joseph.katrina, jeremy.wesley, stephen.brent, alicia.timothy, amber.alex, danielle.alexandra, meghan.christina, cassandra.melanie, jonathan.erika, frank.cassandra, leslie.bradley, philip.adam, gabriel.natalie, nathan.stephen, victor.danielle, julia.gregory, joel.alexandra, justin.bethany, jamie.mary, justin.valerie, nicholas.amber, christina.corey, mary.casey, bryan.wesley, james.cassandra, stephanie.david, edward.meghan, carrie.craig, dana.chad, natalie.amy, mary.cynthia, nicholas.courtney, travis.margaret, peter.alicia, gary.kyle, patricia.erica, nathaniel.timothy, nathan.raymond, sarah.casey, jamie.alicia, alicia.kathleen, frank.donald, douglas.justin, sean.antonio, bethany.jenna, cory.vanessa, jeremy.katherine, cody.peter, george.angela, caitlin.julia, ashley.katrina, charles.brian, erik.cassandra, brandy.margaret, natasha.adam, benjamin.april, meghan.alexandra, vincent.jacqueline, margaret.latoya, mark.curtis, melissa.angela, nicole.juan, ashley.kathryn, kevin.keith, emily.derrick, kelly.kristen, cory.craig, amy.alexander, gregory.philip, kyle.casey, rachel.mary, christopher.meghan, ian.brandon, nathaniel.allison, emily.vanessa, chelsea.travis, leah.corey, krystal.jeffery, rachel.laura, nicholas.brandi, timothy.leah, crystal.frank, samantha.cory, kimberly.megan, ashley.danielle, derek.philip, edward.luis, patrick.jonathan, frank.meghan, chad.marcus, jeffrey.james, amanda.carrie, julia.jeffery, brittney.tiffany, edward.erik, patrick.keith, christina.travis, kenneth.dana, angela.dominique, kimberly.vanessa, marcus.stephen, heather.bethany, bethany.caitlin, sheena.jenna, jenna.raymond, jonathan.alicia, tara.tiffany, corey.whitney, tara.patricia, joseph.gregory, cory.christopher, sean.nathaniel, courtney.erin, raymond.andrea, david.brian, samantha.craig, erik.victoria, tiffany.brittney, shane.megan, christine.emily, richard.anna, juan.ian, candice.brian, monica.natasha, mary.philip, bryan.natalie, christina.holly, leah.sheena, joshua.sarah, adam.christopher, amy.lisa, michael.matthew, frank.brittney, chelsea.larry, richard.erica, paul.larry, kristin.dana, valerie.brian, megan.chelsea, mary.matthew, antonio.shawn, latoya.michelle, sara.juan, mary.kelly, stacey.kristin, kathryn.katherine, christopher.ryan, amanda.tyler, margaret.daniel, julia.william, julia.stephanie, leah.natasha, andrea.jenna, david.megan, benjamin.margaret, curtis.gregory, patricia.thomas, kevin.crystal, brett.carlos, cody.kevin, patrick.andrew, lindsey.kristen, joel.marcus, leah.rebecca, derek.william, michelle.elizabeth, zachary.keith, vincent.michael, zachary.jeffrey, christopher.joel, keith.justin, maria.megan, nicole.rebecca, brandy.corey, antonio.jacqueline, meghan.victor, dustin.veronica, nichole.brandy, john.shannon, shannon.brett, victoria.caitlin, nicole.richard, anna.april, julia.todd, jesse.lauren, kathleen.kelly, krystal.vincent, jamie.william, samuel.natalie, christine.michelle, natalie.adam, veronica.brittney, tiffany.sheena, shannon.bethany, katie.holly, ashley.kevin, anthony.ian, tyler.shane, krystal.anthony, alicia.heather, jose.danielle, andrea.nichole, adrian.brittany, nathaniel.james, dominique.carrie, bradley.jenna, gary.jesse, bethany.leslie, krystal.nicole, bryan.chelsea, julia.jeremy, brittany.peter, matthew.christine, jessica.allison, nichole.kyle, latoya.larry, jennifer.philip, tyler.mark, joel.tyler, kevin.sheena, rebecca.lisa, raymond.patricia, veronica.juan, diana.melissa, erik.sheena, melanie.jessica, curtis.alexandra, cassandra.cody, travis.melissa, zachary.david, juan.aaron, richard.shannon, lindsay.chad, jennifer.shannon, timothy.marcus, eric.elizabeth, carlos.vanessa, alicia.marcus, christine.samantha, brian.kimberly, mary.valerie, alex.michael, margaret.melanie, victoria.ronald, scott.danielle, shawn.steven, april.carlos, natalie.wesley, alexandra.vincent, margaret.megan",
        "IsCompromised":  true
    },
    {
        "HashPrefix":  "7B40C",
        "Timestamp":  "2024-12-17 13:38:33",
        "Users":  "VNCSRV02$",
        "IsCompromised":  false
    }
]
