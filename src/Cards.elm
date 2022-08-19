module Cards exposing (..)
import Html exposing(..)
import Html.Attributes exposing(..)
import Css exposing (..)
import Job exposing (..)

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
    Starter n -> viewEllipse "white" [text ("S" ++ jnum n)]
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



numItems : String -> JobNum -> List (Html m)
numItems s n =
    [ text s
    , br [] []
    , jnum n |> text 
    ]
viewDiscard : JobNum -> Html m
viewDiscard n = 
    div (cardOuterStyle "red"|> itemStyle) 
    [ div (cardInnerStyle  25 35) []  ,text ("-"++ jnum n)]

viewDraw : JobNum -> Html m
viewDraw n = 
    div (cardOuterStyle "Green"|> itemStyle) 
    [ div (cardInnerStyle  25 35) []  ,text ("+"++ jnum n)]

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

--STARTER CARDS

pan : Card
pan = Card "Pan" TGold (Or [Starter (N 2), In Village Free]) [riverGather Gold 1]



boots : Card
boots = Card "Boots" TMove (Starter (N 2)) 
    [foodMove 1 1]

-- Buyable Cards

bigPan : Card
bigPan = Card "Big Pan" TGold (In Village (pay Gold 1))
    [riverGather Gold 3]

pickaxe : Card
pickaxe = Card "Pickaxe" TGold (And [pay Iron 1,pay Wood 1])
    [Job (In Mountain (discard 1)) [gather Iron 3]]

drill : Card
drill = Card "Dril" TWork (In Village (And [pay Iron 2,pay Gold 1 ]))
    [Job (In Mountain (discard 1)) [gather Iron 5]]

sword:Card
sword = Card "Sword" TAttack
    (payEq 1 [Iron,Wood])
    [freeAttack 5 , freeDefend 2]
twinSwords:Card
twinSwords = Card "Twin Swords" TAttack 
    (payEq 2 [Iron, Wood]) 
    [freeAttack 8, freeDefend 4]

shield: Card
shield = Card "Shield" TDefence
    (pay Iron 2)
    [freeDefend 4,freeAttack 1]

horse: Card
horse = Card "Horse" TMove
    (Or [In Prarie (pay Food 3), In Village (pay Gold 1)])
    [foodMove 1 2, scrapFor Food 5]

stalion:Card
stalion = Card "Stalion" TMove 
    (Or [In Prarie (pay Food 4), In Village (pay Gold 2)])
    [ Job (Pay Food (X 2) ) [Movement (X 3)]
    , scrapFor Food 6
    ]

cow: Card
cow = Card "Cow" TFood 
    (Or [In Prarie (pay Food 2), In Village (pay Gold 1)])
    [ gain Food 2 |> freebie
    , scrapFor Food 5 
    ]


wagon:Card
wagon = Card "Wagon" TMove
    (pay Wood 2)
    [ Job ScrapC [gain Wood 2,gain Food 2,draw 2]
    , Job Free [gain Wood 1, gain Food 1, draw 1]
    ]

-- TODO how to make railways
train : Card
train = Card "Train" TMove
    (payL [(Iron,3),(Wood,1)])
    [woodMove 1 3,scrapFor Wood 5 ] 


bow:Card
bow = Card "Bow" TAttack
    (payEq 1 [Wood,Iron])
    [Job (In Forest (pay Wood 1)) [gain Food 3]
    ,Job (pay Wood 1) [attack 3]
    ]

crossbow:Card
crossbow = Card "Crossbow" TAttack (And [pay Wood 3,pay Iron 2])
    [Job (pay Wood 1) [attack 5]]


saw:Card
saw = Card "Saw" TWork 
    ( pay Iron 1) 
    [ Job (In Forest (discard 1)) [gain Wood 3] 
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
