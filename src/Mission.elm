module Mission exposing (Mission,modeStr,campaigns)
import Job as J exposing (on,Job,gain,pay,Resource(..),JobNum (..))

type alias Mission =
    { name : String 
    , difficulty : Int
    , mode : Mode
    , boards : List String
    , setupPic : String
    , setup : List String
    , rules : List String
    , jobs : List Job
    , night : List String
    }

type Mode =
    Solo
    | Coop
    | Verses

modeStr : Mode -> String
modeStr m =
    case m of
        Solo -> "Solo"
        Coop -> "Co-op"
        Verses -> "VS"


campaigns : List Mission
campaigns = [ discovery 
    , theRace 
    , villageHero
    , theFeast
    , builders
    , speedOfTheSlowest
    , buildingTogether
    , dreamWork
    , stopThatWagon
    , preciousCargo
    , escortMission
    , thereAndBackAgain
    , areWeTheBaddies
    ]


discovery : Mission
discovery = { name = "Discovery"
    , difficulty = 1
    , mode = Verses
    , boards = ["A","B"]
    , setup = ["Follow the standard game setup"]
    , setupPic = "basic_vs"
    , rules = []
    , jobs = basicVsScoring
    , night = banditPhase 3
    }

theRace:Mission
theRace = {discovery 
    | name = "The Race"
    , difficulty = 2
    , jobs = 
        [ [on J.OnRevealWest , gain VP 3 , J.Or, on J.OnMoveWest , on J.OnReveal, gain VP 2 ]
        , [on J.OnDefeatBandits, gain Gold 1,gain Wood 1,gain Metal 1,gain Food 1]
        ]

    }

villageHero: Mission
villageHero = {discovery
    | name = "Village Hero"
    , difficulty = 2
    , rules = fedVillage
    , jobs = 
        [ [J.In J.Village, pay Food 2, J.Pay Food (X 1),gain VP 2,J.Gain VP (X 1)]
        , [on J.OnBuild, gain VP 1,J.Or,J.In J.Village, on J.OnBuild , gain VP 2 ]
        , [on J.OnDefeatBandits, gain VP 2, J.Or, J.In J.Village, on J.OnDefeatBandits, gain VP 4 ]
        ]
    }

builders: Mission
builders = {discovery
    | name = "Builders"
    , difficulty = 2
    , rules = []
    , jobs = [buildNWest 2 4,lootDrop Any (D 3)] 
    }


theFeast: Mission
theFeast = { preciousCargo
    | name = "The Feast"
    , difficulty = 2 
    , setupPic = "coop_basic"
    , rules = fedVillage 
    , setup = []
    , jobs =
        [ [J.In J.Village, J.pay Food 5 , J.gain VP 5]
        , [on J.OnDefeatBandits, J.gain Food 2]
        ]
    }

buildingTogether : Mission
buildingTogether = { 
    name = "Building Together"
    , mode = Coop
    , boards = ["C","D"]
    , difficulty = 2
    , setupPic = "coop_basic"
    , rules = []
    , setup = []
    , jobs = [buildNWest 2 4, lootDrop Any (D 3)]
    , night = banditPhase 3
    }

preciousCargo : Mission
preciousCargo = {discovery 
    | name = "Precious Cargo"
    , mode = Coop
    , setupPic = "wagon"
    , boards = ["C","D"]
    , setup = ["- Add a Wagon token to the central start tile" ]
    , rules = moveWagon ++ wagonDamage
    , jobs = 
        [ buildNWest 2 0
        , wagonEastWest 2 ++ [J.Or ,J.On (J.OnWagonDamage (X 1)),J.Pay VP (X 1)]
        , vpDrop 2
        ]
    }

dreamWork : Mission
dreamWork = {preciousCargo 
    | name = "Make the Dream Work"
    , setupPic = "bar"
    , difficulty = 2
    , rules = ["The bar moves west when all players are at least 1 tile west of it"]
    , setup = ["Add the Travel Bar East of the map tiles facing west"]
    ,jobs = [
        [on J.OnBuild, gain VP 1 , J.Or,on J.OnBuildWest, gain VP 2]
        , [on J.OnBarWest, gain VP 2]
        , [on J.OnDefeatBandits , gain VP 2]
        ]
    }
speedOfTheSlowest : Mission
speedOfTheSlowest = {preciousCargo 
    | name = "Speed of the Slowest"
    , setupPic = "bar"
    , difficulty = 1
    , rules = ["The bar moves west when all players are at least 1 tile west of it"]
    , setup = ["Add the Travel Bar East of the map tiles facing west"]
    ,jobs = [
        [on J.OnBarWest, gain VP 3]
        , lootDrop Gold (D 2)
        ]
    }

escortMission : Mission
escortMission = { speedOfTheSlowest
    | name = "Escort Mission"
    , difficulty = 3
    , setup = [ "Add the Travel Bar East of the map tiles facing West"
            , "1 player plays a Character with Difficulty 3"]
    ,jobs = [
        [on J.OnBuild, gain VP 1 ]
        , [on J.OnBarWest, gain VP 3]
        , [on J.OnDefeatBandits , gain VP 1]
        ]
    }

thereAndBackAgain : Mission
thereAndBackAgain = {preciousCargo 
    | name = "There and Back Again"
    , difficulty = 2
    , setupPic = "coop_basic"
    , setup = ["Use a single neutral score token"]
    , jobs = [
        [on J.OnRevealWest, gain VP 3]
        , [ on J.OnDefeatBandits, J.Gain Any (D 3)]
        ]
    , rules = ["Do not remove any tiles from play", "To win you need:","- To complete the score track","- All players on the starting tile" ]
    }

areWeTheBaddies : Mission
areWeTheBaddies = { preciousCargo
    | name = "Are We the Baddies"
    , setupPic = "coop_basic"
    , setup = freeWeapon
    , rules = ["Only players who contributed to the bandit defeat get to roll for gold" ]
    , jobs = [
        [on J.OnDefeatBandits , gain VP 3, J.Gain Gold (D 3)]
        ]
    }

stopThatWagon : Mission 
stopThatWagon = { preciousCargo
    | name = "Stop That Wagon"
    , boards = ["A","B"]
    , setupPic = "wagon_chase"
    , setup = freeWeapon ++ [ "Place the wagon 2 tiles West of all players"]
    , rules = ["Players may attack the wagon", "At the end of the Night phase" , " - Move the Wagon 1 space West revealing tiles as needed"," - Add a bandit to the Wagon's Tile"]
    , jobs = 
        [ [J.On (J.OnWagonDamage (X 1)), J.Gain VP (X 2) ]
        , [J.On J.OnDefeatBandits,gain VP 1]
        ]
    }
    



------ SCORING -------

wagonEastWest : Int -> Job
wagonEastWest n = [on J.OnWagonWest, gain VP n, J.Or, on J.OnWagonEast, J.pay VP n]

basicVsScoring : List Job
basicVsScoring =
    [ revealNWest 1 2
    , buildNWest 2 3
    , lootDrop VP (N 2)
    ]

revealNWest : Int -> Int -> Job
revealNWest r w = 
    case w of
        0 -> [on J.OnReveal,gain VP r]
        _ -> [on J.OnReveal, gain VP r, J.Or ,on J.OnRevealWest, gain VP w]


buildNWest : Int -> Int -> Job
buildNWest b w = 
    case w of
        0 -> [on J.OnBuild,gain VP b]
        _ -> [on J.OnBuild, gain VP b, J.Or ,on J.OnBuildWest, gain VP w]

vpDrop : Int -> Job
vpDrop n = 
    lootDrop VP (N n)

lootDrop : Resource -> JobNum -> Job
lootDrop r n = 
    [on J.OnDefeatBandits, J.Gain r n]



----- RULES ---- 

fedVillage : List String
fedVillage =["When you feed a village, place a food token there to mark it as fed", "You cannot feed a fed village"]

moveWagon : List String
moveWagon = ["To move the Wagon a player must:","- Be on the same square as the wagon", "- Use their own movement actions"]

wagonDamage : List String
wagonDamage = ["The wagon takes 1 damage leaving bandits and may be attacked by bandits"]

freeWeapon : List String 
freeWeapon = ["Players may all take 1 weapon (Red Card) from the trade row draw pile"]

---------Bandit Phase

banditPhase : Int -> List String
banditPhase d = 
    let
        head = [ "Move Trade row"
            , "Move Bandit Tracker"
            , "Take an 'E' Danger"
            , "Bandits attack"
            , "Bandits move"
            ]
        rm = if d == 0 then 
                [] 
            else 
                [ "Remove tiles"
                , " (>" ++ String.fromInt d ++ " east of all players)"
                ]
        tail = ["Bandits Appear"]
    in
        head ++ rm ++ tail


