module Mission exposing (Mission,modeStr,allCampaigns)
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
    | Versus

modeStr : Mode -> String
modeStr m =
    case m of
        Solo -> "Solo"
        Coop -> "Co-op"
        Versus -> "VS"


allCampaigns : List Mission
allCampaigns = vsCampaigns ++ coopCampaigns ++ soloCampaigns 

vsCampaigns : List Mission
vsCampaigns = [ discovery 
    , theRace 
    , villageHero
    , builders
    ]




discovery : Mission
discovery = { name = "Discovery"
    , difficulty = 1
    , mode = Versus
    , boards = ["A","B"]
    , setup = standardSetup
    , setupPic = "basic_vs"
    , rules = []
    , jobs =  vsUtil ++ basicVsScoring
    , night = nightPhase Versus 3
    }

theRace:Mission
theRace = {discovery 
    | name = "The Race"
    , difficulty = 2
    , jobs = 
        vsUtil ++ [ [on J.OnReveal,J.In J.MovingWest, gain VP 2 , J.In J.WestMost , gain VP 1 ]
        , [on J.OnDefeatBandits, gain Gold 1,gain Wood 1,gain Metal 1,gain Food 1]
        ]

    }

villageHero: Mission
villageHero = {discovery
    | name = "Village Hero"
    , difficulty = 2
    , rules = fedVillage
    , jobs = 
        vsUtil ++ [ [J.In J.Village, pay Food 2, J.Pay Food (X 1),gain VP 2,J.Gain VP (X 1)]
        , [on J.OnBuild, gain VP 1,J.In J.Village, gain VP 1 ]
        , [on J.OnDefeatBandits, gain VP 2,J.In J.Village, gain VP 2 ]
        ]
    }

builders: Mission
builders = {discovery
    | name = "Builders"
    , difficulty = 2
    , rules = []
    , jobs = vsUtil ++ [buildN 2 |> westMost 2,lootDrop Any (D 3)] 
    }


theFeast: Mission
theFeast = { preciousCargo
    | name = "The Feast"
    , difficulty = 2 
    , setupPic = "coop_basic"
    , rules = fedVillage 
    , setup = []
    , jobs =
        coopJobs ++ [ [J.In J.Village, J.pay Food 5 , J.gain VP 5]
        , [on J.OnDefeatBandits, J.gain Food 2]
        ]
    }

coopCampaigns : List Mission
coopCampaigns = 
    [ speedOfTheSlowest
    , buildingTogether
    , dreamWork
    , theFeast
    , stopThatWagon
    , preciousCargo
    , escortMission
    , thereAndBackAgain
    , areWeTheBaddies
    ]

buildingTogether : Mission
buildingTogether = { 
    name = "Building Together"
    , mode = Coop
    , boards = ["C","D"]
    , difficulty = 2
    , setupPic = "coop_basic"
    , rules = []
    , setup = []
    , jobs = coopJobs ++ [buildN 2 |> westMost 2, lootDrop Any (D 3)]
    , night = nightPhase Coop 3
    }

preciousCargo : Mission
preciousCargo = {
    name = "Precious Cargo"
    , mode = Coop
    , difficulty = 1
    , setupPic = "wagon"
    , boards = ["C","D"]
    , setup = ["- Add a Wagon token to the central start tile" ]
    , rules = moveWagon ++ wagonDamage
    , jobs = 
        coopJobs ++ [ buildN 2 |> westMost 0
        , wagonEastWest 2 
        , [J.On (J.OnWagonDamage (X 1)),J.Pay VP (X 1)]
        , vpDrop 2
        ]
    , night = nightPhase Coop 3
    
    }

dreamWork : Mission
dreamWork = {preciousCargo 
    | name = "Make the Dream Work"
    , setupPic = "bar"
    , difficulty = 2
    , rules = ["The bar moves west when all players are at least 1 tile west of it"]
    , setup = ["Add the Travel Bar East of the map tiles facing west"]
    ,jobs = coopJobs ++ [
        buildN 1 |> westMost 1
        , [on J.OnBarWest, gain VP 2]
        , lootDrop VP (N 2)
        ]
    }
speedOfTheSlowest : Mission
speedOfTheSlowest = { preciousCargo 
    | name = "Speed of the Slowest"
    , setupPic = "bar"
    , difficulty = 1
    , rules = ["The bar moves west when all players are at least 1 tile west of it"]
    , setup = ["Add the Travel Bar East of the map tiles facing west"]
    ,jobs = coopJobs ++ [
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
    ,jobs = coopJobs ++ [
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
    , jobs = coopJobs ++ [
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
    , jobs = coopJobs ++ [
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
        coopJobs ++ [ [J.On (J.OnWagonDamage (X 1)), J.Gain VP (X 2) ]
        , [J.On J.OnDefeatBandits,gain VP 1]
        ]
    }

-------- SOLO Campaigns

soloCampaigns : List Mission
soloCampaigns = [newWorld,doubleTrouble]


newWorld : Mission
newWorld = { 
    name = "New World"
    , difficulty = 1
    , mode = Solo
    , boards = ["A","B"]
    , setup = standardSetup
    , setupPic = "basic_vs"
    , rules = []
    , jobs =  soloUtil ++ basicVsScoring
    , night = nightPhase Solo 4
    }

doubleTrouble : Mission
doubleTrouble = { newWorld 
    | name = "Double Trouble"
    , setup = ["Add 2 Meeples to the board for 1 player", "Add the Travel Bad at the East of the Board"]
    , rules  = ["You can do any job with either meeple, but not both"]
    , jobs = soloUtil ++ [[J.On J.OnBarWest,gain VP 3 ]]
    }

------ SCORING -------


vsUtil : List Job
vsUtil = [cardsForFood 3 1,goldForTrain 1 5 ] 

coopJobs : List Job
coopJobs = [goldForTrain 2 3]

soloUtil : List Job
soloUtil = [goldForTrain 1 4]


cardsForFood : Int -> Int -> Job 
cardsForFood n f =
    [J.Discard J.TAny (N n),gain J.Food f]

goldForTrain : Int -> Int -> Job
goldForTrain n d =
    [pay Gold n, J.RideTrain (N d) ]


wagonEastWest : Int -> Job
wagonEastWest n = [on J.OnWagonWest, gain VP n, J.Or, on J.OnWagonEast, J.pay VP n]

basicVsScoring : List Job
basicVsScoring =
    [ revealN 1 |> westMost 1
    , buildN 2 |> westMost 1
    , lootDrop VP (N 2)
    ]


revealN : Int -> Job
revealN r = [on J.OnReveal,gain VP r]

westMost : Int -> Job -> Job
westMost n j = j ++ [J.In J.WestMost, gain VP n]


buildN : Int -> Job
buildN b = 
    [on J.OnBuild,gain VP b] 

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

nightPhase : Mode -> Int -> List String
nightPhase md d = 
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
        p1t = case md of
            Versus -> ["Pass the P1 token"]
            _ -> []


        tail = ["Bandits Appear"]
    in
        head ++ rm ++ tail ++ p1t


--------------Setups
standardSetup : List String
standardSetup = ["Follow the standard game setup"]

