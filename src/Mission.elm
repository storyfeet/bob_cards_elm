module Mission exposing (Mission,allCampaigns)
import Job as J exposing (on,Job,gain,pay,Resource(..),JobNum (..))
import MissionSetup as MP

type alias Mission =
    { name : String 
    , difficulty : Int
    , mode : MP.Mode
    , boards : List String
    , setupPic : String
    , setup : List MP.Setup
    , rules : List String
    , jobs : List Job
    , night : List String
    }



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
    , mode = MP.Versus
    , boards = ["A","B"]
    , setup = [MP.Grid 2,MP.ThreeMeeples]
    , setupPic = "basic_vs"
    , rules = ["- For players who want a fair but close game -"]
    , jobs =  vsUtil  ++ basicVsScoring
    , night = nightPhase MP.Versus 3
    }

theRace: Mission
theRace = {discovery 
    | name = "The Race"
    , difficulty = 3
    , jobs = 
        vsUtil ++ [ [on J.OnReveal,J.In J.MovingWest, gain VP 2 ]
        , [on J.OnReveal, J.In J.WestMost , gain VP 1 ]
        , [on J.OnDefeatBandits, gain Gold 1,gain Wood 1,gain Metal 1,gain Food 1]
        ]
    , setup = [MP.Grid 2,MP.ThreeMeeples,MP.Scrap "Mallets" ]
    , rules = ["- For advanced players who are happy to leave a man behind -","Train Rides may go from Village to Village if there are no bandits on either"]
    }

villageHero: Mission
villageHero = {discovery
    | name = "Village Hero"
    , difficulty = 2
    , rules = "- For players who like hunting and gathering -"::fedVillage
    , setup = [MP.Grid 2,MP.ThreeMeeples]
    , jobs = 
        vsUtil ++ [ [J.In J.Village, pay Food 2, J.Pay Food (X 1),gain VP 2,J.Gain VP (X 1)]
        , [on J.OnBuild, gain VP 1,J.In J.Village, gain VP 1 ]
        , [on J.OnDefeatBandits, gain VP 2,J.In J.Village, gain VP 2 ]
        ]
    }

builders: Mission
builders = {discovery
    | name = "Builders"
    , difficulty = 3
    , setup = [MP.Grid 2,MP.ThreeMeeples]
    , rules = ["- For players who want a hard challenge -"]
    , jobs = vsUtil ++ [buildRail 3 1 , buildN 3 |> westMost 2,lootDrop Any (D 3)] 
    }



coopCampaigns : List Mission
coopCampaigns = 
    [ speedOfTheSlowest
    , buildingTogether
    , dreamWork
    , theFeast
    , stopThatWagon
    , preciousCargo
    , thereAndBackAgain
    , areWeTheBaddies
    ]

theFeast: Mission
theFeast = { preciousCargo
    | name = "The Feast"
    , difficulty = 3 
    , setupPic = "coop_basic"
    , rules = "- For players who want to work together to give -"::fedVillage 
    , setup = [MP.Grid 2,MP.ThreeMeeples]
    , jobs =
        coopUtil ++ [ [J.In J.Village, J.pay Food 5 , J.gain VP 5]
        , [on J.OnDefeatBandits, J.gain Food 3, J.gain VP 1]
        ]
    }

buildingTogether : Mission
buildingTogether = { 
    name = "Building Together"
    , mode = MP.Coop
    , boards = ["C","D"]
    , difficulty = 3
    , setupPic = "coop_basic"
    , rules = ["- For players who can take a challenge together -"]
    , setup = [MP.Grid 2,MP.ThreeMeeples]
    , jobs = coopUtil ++ [buildN 2 |> westMost 2, lootDrop Any (D 3)]
    , night = nightPhase MP.Coop 3
    }

preciousCargo : Mission
preciousCargo = {
    name = "Precious Cargo"
    , mode = MP.Coop
    , difficulty = 2
    , setupPic = "wagon"
    , boards = ["C","D"]
    , setup = [MP.Grid 2,MP.ThreeMeeples,MP.Wagon 0]
    , rules = "- For players who love escort missions -"::moveWagon ++ wagonDamage
    , jobs = 
        coopUtil ++ [ buildN 2 |> westMost 0
        , wagonEastWest 2 
        , [J.On (J.OnWagonDamage (X 1)),J.Pay VP (X 1)]
        , vpDrop 2
        ]
    , night = nightPhase MP.Coop 3
    
    }

dreamWork : Mission
dreamWork = {preciousCargo 
    | name = "Make the Dream Work"
    , setupPic = "wagon"
    , difficulty = 2
    , rules = ["- For team players -","The Wagon moves west when all players are at least 1 tile west of it", "It does not take damage"]
    , setup = [MP.Grid 2,MP.ThreeMeeples,MP.Wagon 0]
    ,jobs = coopUtil ++ [
        buildN 1 |> westMost 1
        , [on J.OnWagonWest, gain VP 2]
        , lootDrop VP (N 2)
        ]
    }

speedOfTheSlowest : Mission
speedOfTheSlowest = { preciousCargo 
    | name = "Speed of the Slowest"
    , setupPic = "wagon"
    , difficulty = 1
    , rules = ["- For players who won't leave a man behind -","The Wagon moves west when all players are at least 1 tile west of it", "It does not take damage"]
    , setup = [MP.Grid 2, MP.ThreeMeeples,MP.Wagon 0]
    ,jobs = coopUtil ++ [
        [on J.OnWagonWest, gain VP 3]
        , lootDrop Gold (D 2)
        ]
    }


thereAndBackAgain : Mission
thereAndBackAgain = {preciousCargo 
    | name = "There and Back Again"
    , difficulty = 2
    , setupPic = "coop_basic"
    , setup = [MP.Grid 2,MP.ThreeMeeples,MP.Wagon 0] 
    , jobs = coopUtil ++ [
        [on J.OnReveal, J.In J.WestMost, gain VP 3]
        , [ on J.OnDefeatBandits, J.Gain Any (D 3)]
        ]
    , rules = ["- For team players who want a challenge -","Do not remove any tiles from play","The Wagon does not move, and cannot be attacked", "You may not reveal more than 4 tiles North to South on a row.", "To win you need:","- To complete the score track","- All players on the starting tile with the wagon" ]
    , night = nightPhase MP.Coop 0 
    }

areWeTheBaddies : Mission
areWeTheBaddies = { preciousCargo
    | name = "Are We the Baddies"
    , difficulty = 3
    , setupPic = "coop_basic"
    , setup = [MP.Grid 2,MP.ThreeMeeples]
    , rules = ["- For players who want a fight -","Only players who contributed to the bandit defeat get to roll for gold" ]
    , jobs = coopUtil ++ 
        [ [ J.Discard J.TAny (N 2),J.attack 2,J.defend 1 ]
        , [ on J.OnDefeatBandits , gain VP 3, J.Gain Gold (D 3)]
        ]
    }

stopThatWagon : Mission 
stopThatWagon = { preciousCargo
    | name = "Stop That Wagon"
    , boards = ["A","B"]
    , setupPic = "wagon_chase"
    , setup = [MP.Grid 3,MP.ThreeMeeples, MP.Wagon 2, MP.Bandits [1,2]]
    , rules = ["- For players who want a fight -","Players may attack the wagon", "At the end of the Night phase" , " - Move the Wagon 1 space West revealing tiles as needed"," - Add a bandit to the Wagon's Tile"]
    , jobs = 
        coopUtil ++ [ [J.On (J.OnWagonDamage (X 1)), J.Gain VP (X 2) ]
        , [J.On J.OnDefeatBandits,gain VP 1]
        ]
    }

-------- SOLO Campaigns

soloCampaigns : List Mission
soloCampaigns = [newWorld,doubleTrouble,railwayMan]


newWorld : Mission
newWorld = { 
    name = "New World"
    , difficulty = 1
    , mode = MP.Solo
    , boards = ["A","B"]
    , setup = [MP.Grid 2, MP.OneMeeple]
    , setupPic = "basic_vs"
    , rules = ["- The straight forward beginner mission -"]
    , jobs =  soloUtil ++ basicVsScoring
    , night = nightPhase MP.Solo 4
    }

doubleTrouble : Mission
doubleTrouble = { newWorld 
    | name = "Double Trouble"
    , difficulty = 2
    , setup = [MP.Grid 2, MP.TwoMeeples, MP.Wagon 0]
    , rules  = ["- For a player who wants to shake up the experience -","You can do any job with either meeple, but not both","Move the Wagon by having one of your meeples on the same tile, then move it as you would yourself", "The wagon may not be attacked by bandits"]
    , jobs = soloUtil ++ [[J.On J.OnWagonWest,gain VP 3 ]]
    , setupPic = "wagon"
    }

railwayMan : Mission
railwayMan = { 
    name = "Railway Man"
    , difficulty = 3
    , mode = MP.Solo
    , boards = ["A","B"]
    , setup = [MP.Grid 2,MP.OneMeeple]
    , setupPic = "basic_vs"
    , rules = ["- For a player who know's what he's doing and is up for the challenge -"]
    , jobs =  soloUtil ++ 
        [ buildRail 3 1
        , [J.on J.OnReveal ,J.In J.WestMost,gain VP 1 ]
        , [J.on J.OnBuild , gain VP 2, J.In J.WestMost, gain VP 3]
        ]
    , night = nightPhase MP.Solo 4
    }
------ SCORING -------


vsUtil : List Job
vsUtil = [vpCardsForClimb 2 2 1,pointsForScrap 4 3,goldForTrain 1 5 ] 

coopUtil : List Job
coopUtil = [goldForTrain 1 3]

soloUtil : List Job
soloUtil = [goldForTrain 1 4]


buildRail : Int -> Int -> Job
buildRail cards gold = 
     [J.Discard J.TAny (N cards),pay Gold gold, pay Metal 1, pay Wood 1,J.BuildRail]   

--cardsForFood : Int -> Int -> Job 
--cardsForFood n f =
--    [J.Discard J.TAny (N n),gain J.Food f]


vpCardsForClimb: Int -> Int -> Int -> Job
vpCardsForClimb v c d = [pay VP v ,J.Discard J.TAny (N c),J.MountainMove (N d)]

pointsForScrap : Int -> Int -> Job
pointsForScrap n s =
    [J.pay VP n,J.scrap (J.TDanger J.DAny) s ]

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

nightPhase : MP.Mode -> Int -> List String
nightPhase md d = 
    let
        head = [ "Move the Trade Row"
            , "Move the Day Tracker"
            , "Take an 'E' Danger"
            , "Bandits attack"
            , "Bandits move"
            ]
        rm = if d == 0 then 
                [] 
            else 
                [ "Remove tiles > " ++ String.fromInt d ++ " East" 
                , "    of all players"
                ]
        p1t = case md of
            MP.Versus -> ["Pass the P1 token"]
            _ -> []


        tail = ["Bandits Appear","Bandits Split at 7","Full Hand check"]
    in
        head ++ rm ++ tail ++ p1t


