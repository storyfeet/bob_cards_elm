module Player exposing (Player,players,reqList)

import Cards exposing (Card)
import Decks.Starter as DS exposing (..)
import Job exposing (..)
import Dict exposing (Dict)
import Decks.Trade exposing (..)

startRes : List (Resource, Int) -> Job
startRes = 
    List.map (\(r,n) -> gain r n) 

standardRes : Job
standardRes = startRes [(Gold,1),(Metal,1),(Wood,1),(Food,3)]

type alias Player =
    { name : String
    , difficulty : Int
    , handSize : Int
    , startItems : Job
    , jobs : List Job.Job
    , startCards : List ( Card, Int )
    }

type alias ReqList = Dict String (Card,List Int)

players : List Player
players = 
    [ jakeWilder,blazeDecker,caseyRocks,samBoater,elisaWatton,wayneJohns,derekDogood

    , claytonConnel,dorotheaDuke,carlaDirk,jebSteal,driftinaWood,alysBear

    ,bryantCarrot , washCardman
    ]




reqCard : Card -> Int -> ReqList-> ReqList
reqCard c n list= 
    let 
        (_,cl) = Dict.get c.name list |> Maybe.withDefault (c,[])
    in
        Dict.insert c.name (c,n::cl) list

reqPlayer : Player -> ReqList ->  ReqList
reqPlayer p rl = List.foldl (\(c,n) ls -> reqCard c n ls ) rl p.startCards

reqPlayers : List Player -> ReqList -> ReqList
reqPlayers pl rl =
    List.foldl (reqPlayer) rl pl

reqList : Int -> List (Card, Int)
reqList n =
    reqPlayers players Dict.empty
    |> Dict.values 
    |> List.map (\(c,v) ->(c, List.sort v |> List.reverse |> List.take n |> List.sum))
--    |> List.map (\(c,v) -> (cme,v))


-- Basic 1
jakeWilder : Player
jakeWilder =
    Player "Jake Wilder" 1 6
        standardRes
        [ [ discard, Move (N 1) ]
        , [ Scrap TAny (N 1) ]
        , [ Discard (TDanger DAny) (N 2) ]
        ]
        (DS.coreMinPlus [pan] [(bigPan,1)] )

--Moutain 1
caseyRocks : Player
caseyRocks = 
    Player "Casey Rocks" 1 6
        (startRes [(Gold,2 ), (Food,5)])
        [ [ pay Any 1,Discard TAny (N 1), MountainMove (N 1) ]
        , [defend 1]
        , [ Scrap TAny (N 1), Scrap (TDanger DAny) (N 1) ]
        ]
        (DS.coreMinPlus [boots,pickaxe] [(climbingBoots, 2), (pickaxe ,2)])


--Water 1
samBoater : Player
samBoater =
    Player "Sam Boater" 1 6
        standardRes  
        [ [ Draw (N 1), Scrap TAny (N 1) ]
        , [ In Water, Scrap (TDanger DAny) (X 1) ]
        , [ Pay Any (N 1), WaterMove (N 1) ]
        ]
        (coreMinPlus [saw,knife] [(net,2),(axe, 1)])

--Farmer 1
elisaWatton : Player
elisaWatton =
    Player "Elisa Watton" 1 6
        standardRes
        [ [ Take (TDanger Exhaustion) (N 1), Move (N 1) ]
        , muligan 
        , [ Scrap TAny (N 2),draw 1 ]
        ]
        (coreMinPlus [knife] [(cow,2)])

-- Hunter 1
blazeDecker : Player
blazeDecker = 
    Player "Blaze Decker" 1 6
    standardRes
    [ [ discard, Move (N 1)]
    , [ scrap TAny 1, scrap anyDanger 1]
    , muligan
    ] 
    (coreMinPlus [knife] [(huntingKnife , 2)])

-- Fighter 1

wayneJohns : Player
wayneJohns = 
    Player "Wayne Johns" 1 6
    (startRes [(Gold, 1),(Wood,2),(Food, 4)])
    [ [attack 2]
    , [Pay Any (N 1),Pay Food (X 1), Move (X 1)]
    , [scrap TAny 1, Discard TAny (X 1), Gain Food (X 1)]
    ]
    (coreMinPlus [knife] [(knife,1),(revolver,1)])


-- Trader 1
derekDogood : Player
derekDogood =
    Player "Derek Dogood" 1 6
    (startRes [(Gold,1),(Metal,1),(Wood,1),(Food,3)])
    [ [pay Any 1, Move (N 1)]
      , [discard, Pay Any (X 1),Gain Any (X 1)]
      , [Scrap TAny (X 1),Gain Any (X 1)]
    ]
    (coreMinPlus [rookieTrader] [])


-- Basic 2

claytonConnel : Player
claytonConnel =
    Player "Clayton Connel" 2 5
        standardRes
        [ [ discard, Move (N 1) ]
        , [ Scrap TAny (N 1) ]
        , [ Discard (TDanger DAny) (X 1) ]
        ]
        (DS.basicDeck )

-- Mountain 2
dorotheaDuke : Player
dorotheaDuke = 
    Player "Dorothea Duke" 2 6
        (startRes [(Gold,2 ), (Food,5)])
        [ [ Discard TAny (N 2), MountainMove (N 1) ]
        , [ pay Food 2, Move (N 1) ]
        , [ Scrap TAny (N 1), Scrap (TDanger DAny) (N 1) ]
        ]
        (DS.coreMinPlus [boots,pickaxe] [(climbingBoots, 2), (pickaxe ,2)])

-- Water 2
-- (fisher Byrd)

driftinaWood : Player
driftinaWood = 
    Player "Driftina Wood" 2 5
        standardRes  
        [ [ In Water,Scrap TAny (N 1),gather Food 2 ]
        , [ In Water,pay Any 1, Scrap (TDanger DAny) (X 1) ]
        , [ Pay Any (N 1) ,Pay Any (X 1), WaterMove (X 1)]
        ]
        (coreMinPlus [saw,knife] [(net,1),(axe, 2)])

-- Farmer 2
jebSteal : Player
jebSteal =
    Player "Jeb Steal" 2 6
        standardRes 
        [ [ Take (TDanger Exhaustion) (N 1), Move (N 1) ]
        , [ pay Any 1, Discard (TDanger DAny) (N 1) ]
        , [ pay Any 2, scrap (TAny) 1]
        ]
        (coreMinPlus [knife] [(cow,1)])


-- Hunter 2

alysBear : Player
alysBear = 
    Player "Alys Bear" 2 6
    standardRes
    [ [ discard,Discard anyDanger (N 1),Scrap TAny (X 1)]
    , [ Discard TAny (N 1),scrap anyDanger 1 ]
    , [ Discard anyDanger (N 1), Move (N 1)]
    ] 
    (coreMinPlus [knife] [(huntingKnife , 2)])

-- Fighter 2

carlaDirk : Player
carlaDirk = 
    Player "Carla Dirk" 2 5
    (startRes [(Gold, 1),(Wood,2),(Food, 4)])
    [ [attack 2]
    , [Pay Food (X 1), Move (X 1)]
    , [Pay Any (X 1) ,Scrap (TDanger Pain) (X 1)]
    ]
    (coreMinPlus [knife] [(knife,1),(revolver,1)])

-- Basic 3

bryantCarrot : Player
bryantCarrot =
    Player "Bryant Carrot" 3 4
    (startRes [(Gold, 1), (Wood , 1) ,(Metal,1),(Food,3)])
    [ [ Scrap anyDanger (N 1), move 1]
    , [ Scrap TAny (N 1), move 1]    
    ]
    (coreMinPlus [] [])

washCardman : Player
washCardman =
    Player "Wash Cardman" 3 5
    standardRes
    [ muligan
    , [Discard TMove (N 1) ,Discard TGather (N 1),Move (N 1)]
    ]
    (coreMinPlus [] [])



{-- Types
Basic
Mountain 
Water
Farmer
Hunter
Fighter
Trader


--}

{-- NAMES
Josephine Willow

Jane Clarence


--}
