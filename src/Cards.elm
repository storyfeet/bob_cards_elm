module Cards exposing (..)
import Html exposing(..)
import Html.Attributes exposing(..)
import Css exposing (..)

type alias Card =
    { name : String
    , ctype : CType
    , cost : Cost
    , jobs : List Job
    }

type CType 
    = TAttack
    | TDefence
    | TMove
   | TGold
    | TFood
    | TCarry
    | TWork



type alias Job =
    { req : Cost
    , for : List Benefit
    }


type Place 
    = Water
    | Forest
    | Prarie
    | Village
    | Mountain
    | River

type Resource  
    = Gold
    | Wood
    | Iron
    | Food

type Cost
    = In Place Cost
    | Or (List Cost)
    | And (List Cost)
    | Discard Int
    | Pay Resource Int
    | ScrapC
    | Free


view : Card -> Html m
view crd = div (cardStyle (cTypeColor crd.ctype))
    [ text crd.name
    , div [style "width" "30",style "position" "absolute", style "right" "0", style "top" "0"] [viewCost crd.cost]
    , crd.jobs |> List.map viewJob |> div [style "position" "absolute" ,style "bottom" "0"] 
    ]



viewJob :Job -> Html m
viewJob jb =
    div [style "clear" "both"] 
    ([ viewCost jb.req 
    , div (itemStyle []) [text "=>"]]++
     (List.map viewBenefit jb.for))
     


viewCost : Cost -> Html m
viewCost cst = 
   case cst of 
    In plac ch -> div [] [viewPlace plac, viewCost ch]
    Or l -> l |> List.map viewCost  |> div [classList[( "or_cost",True )]]
    And l -> l |> List.map viewCost  |> div [classList [("and_cost",True)]]
    Discard n -> viewDiscard n
    Pay r n -> viewRect (resourceColor r) (numItems (resourceShortName r) n )
    ScrapC -> viewEllipse "pink" [text "Scrp"]
    Free -> div [] [] 


viewBenefit: Benefit -> Html m
viewBenefit bn =
    case bn of
        Movement n -> viewEllipse "lightblue" (numItems "Mv" n)
        Attack n -> viewEllipse "red" (numItems "Atk" n)
        Defend n -> viewEllipse "Grey" (numItems  "Dfd" n)
        Gain r n -> viewRect (resourceColor r) (numItems (resourceShortName r) n)
        Gather r n -> viewEllipse (resourceColor r) (numItems (resourceShortName r)  n)
        Draw n -> viewDraw n
        ScrapB n-> viewEllipse "pink" (numItems "Scp" n)



numItems : String -> Int -> List (Html m)
numItems s n =
    [ text s
    , br [] []
    , String.fromInt n |> text 
    ]
viewDiscard : Int -> Html m
viewDiscard n = 
    div (cardOuterStyle "red"|> itemStyle) 
    [ div (cardInnerStyle  25 35) []  ,text ("-"++ String.fromInt n)]

viewDraw : Int -> Html m
viewDraw n = 
    div (cardOuterStyle "Green"|> itemStyle) 
    [ div (cardInnerStyle  25 35) []  ,text ("+"++ String.fromInt n)]

resourceShortName : Resource -> String
resourceShortName r = 
    case r of
        Gold -> "Gld"
        Wood -> "Wd"
        Iron -> "Ir"
        Food -> "Fd"

placeShortName: Place -> String  
placeShortName pl =
    case pl of
        River -> "Rvr"
        Forest -> "Frt"
        Mountain -> "Mtn"
        Prarie -> "Pry"
        Water -> "Wtr"
        Village -> "Vlg"


cTypeColor : CType -> String
cTypeColor ct = 
    case ct of
       TAttack -> "red"
       TDefence -> "lightgrey"
       TMove -> "lightblue"
       TGold -> "gold"
       TFood -> "lightgreen"
       TWork -> "LightBlue"
       TCarry -> "Blue"

placeColor: Place -> String
placeColor pl = 
    case pl of
        River -> "Cyan"
        Forest -> "Green"
        Mountain -> "Grey"
        Prarie -> "LightGreen"
        Water -> "Blue"
        Village -> "Yellow"
        
resourceColor: Resource ->String
resourceColor r = 
    case r of 
        Food -> "green"
        Iron -> "silver"
        Wood -> "Brown"
        Gold -> "Gold"



viewPlace : Place -> Html m
viewPlace plc = 
    div (hexStyle "black" 35 |> itemStyle)[
        div (hexStyle (placeColor plc ) 31) [
            text (placeShortName plc)]
        ]

viewEllipse:String -> List( Html m)  -> Html m
viewEllipse col inner =
    div (circleStyle  "black" 35 |> itemStyle) [
        div (circleStyle col 31) 
            inner
        ]

viewRect: String -> List (Html m) -> Html m
viewRect col inner = 
    div (squareStyle col 35 |> itemStyle ) inner





payL : List (Resource, Int) -> Cost
payL l =
    l |> List.map (\(r,n) -> Pay r n) |> And

payEq : Int ->  List Resource -> Cost
payEq n l =
    l |> List.map (\r-> Pay r n) |> And

type Benefit
    = Movement Int
    | Attack Int
    | Defend Int
    | Gain Resource Int
    | Gather Resource Int
    | Draw Int
    | ScrapB Int


-- JOBS
riverGather : Int ->Job
riverGather n = Job (In River Free) [Gather Gold n]

foodMove : Int -> Int -> Job
foodMove f d = Job (Pay Food f) [Movement d]

woodMove : Int -> Int -> Job
woodMove w d = Job (Pay Wood w) [Movement d]


scrapFor : Resource -> Int -> Job
scrapFor r n =
    Job ScrapC [Gain r n]


freeAttack : Int -> Job
freeAttack a = Job Free [Attack a]
freeDefend : Int -> Job
freeDefend d = Job Free [Defend d]


-- Decks
starterDeck : List (Card,Int)
starterDeck = [(pan,2),(horse,2),(bow,2)]

tradeRow : List (Card,Int)
tradeRow = 
    [(pan,3)
    ,(saw, 2)
    ,(horse,2)
    ,(twinSwords,2) 
    ,(wagon,3)
    ,(sword,3)
    ,(train,2)
    ,(bow,3)
    ]


-- ACTUAL CARDS

pan : Card
pan = Card "Pan" TGold (Pay Iron 1) [riverGather 1]


twinSwords:Card
twinSwords = Card "Twin Swords" TAttack 
    (payL [(Iron, 3), (Wood, 2)]) 
    [freeAttack 12, freeDefend 5]

shield: Card
shield = Card "Shield" TDefence
    (Pay Iron 4)
    [freeDefend 10,freeAttack 5]

horse:Card
horse = Card "Horse" TMove
    (Or [In Prarie (Pay Food 3), In Village (Pay Gold 1)])
    [foodMove 3 1, scrapFor Food 5]

wagon:Card
wagon = Card "Wagon" TMove
    (Pay Wood 2)
    [ Job ScrapC [Gain Wood 2,Gain Food 2,Draw 2]
    , Job Free [Gain Wood 1, Gain Food 1, Draw 1]
    ]

sword:Card
sword = Card "Sword" TAttack
    (payEq 1 [Iron,Wood])
    [freeAttack 5 , freeDefend 1]

train:Card
train = Card "Train" TMove
    (payL [(Iron,3),(Wood,1)])
    [woodMove 1 3,scrapFor Wood 5 ] 


bow:Card
bow = Card "Bow" TAttack
    (payEq 1 [Wood,Iron])
    [Job (In Forest (Pay Wood 1)) [Gain Food 3]
    ,Job (Pay Wood 1) [Attack 3]
    ]

saw:Card
saw = Card "Saw" TWork 
    (Pay Iron 1) 
    [ Job (In Forest (Discard 1)) [Gain Wood 3] 
    ]



{--


3*"CrossBow",Attack
.cost : [[Wood , 5] , [Iron , 3] , [Iron , 1]]
.jobs*$req : [[Iron , 2]]
.jobs.$for : [[Food , 3] , [Attack , 5] , [Defence , 0]]
.jobs*$req:[Scrap]
.jobs.$for : [[Wood, 2]]

1*"Harpoon",Attack
.cost : [[Wood , 1][Iron , 1]]
.jobs*$req : []
.jobs.$for : [[Food "2d6:L"] , [Card 1]]
.jobs*$req:[Scrap]
.jobs.$for : [[Attack , "2d6:H"]]

5*"Trident",Food
.cost : [[Iron , 5]]
.jobs*$req : []
.jobs.$for : [[Food , "2d6:H"] [Card 2]]
.jobs*$req:[Scrap]
.jobs.$for : [[Attack , "2d6+2"]]

4*"Twin Shields",Attack
.cost : [[Iron , 5]]
.jobs*$req : []
.jobs.$for : [[Defence , 15] , [Attack]]
.jobs*$req:[Scrap]
.jobs.$for : [Iron , 2]

2*"Blue Gun",Attack
.cost : [[Iron , 4] , [Wood , 7]]
.jobs*$req : [[Iron , 3]]
.jobs.$for : [[Attack , 20]]
.jobs*$req:[Scrap]
.jobs.$for : [[Iron , 2] , [Wood , 5]]

3*"BuckShot",Attack
.cost : [[Iron , 6]]
.jobs*$req : [Iron]
.jobs.$for : [[Attack , 20]]

4*"Hammer",Construction
.cost : [[Wood ,2]]
.jobs*$req : []
.jobs.$for : [[Wood , 10]]

2*"Whip",Attack
.cost : [Wood, 1]
.jobs*$req : []
.jobs.$for : [[Attack, 5]]


--}
