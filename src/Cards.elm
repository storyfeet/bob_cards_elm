module Cards exposing (..)

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



type alias Job =
    { req : Cost
    , for : List Benefit
    }


type Place 
    = Water
    | Forest
    | Prarie
    | Town
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
    | ScrapB


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
    (Or [In Prarie (Pay Food 3), In Town (Pay Gold 1)])
    [foodMove 3 1, scrapFor Food 5]

wagon:Card
wagon = Card "Wagon" TMove
    (Pay Wood 2)
    [ Job ScrapC [Gain Wood 2,Gain Food 2,Draw 2]
    , Job Free [Gain Wood 1, Gain Food 1, Draw 1]
    ]

sword:Card
sword = Card "Sword" TAttack
    (payL [(Iron,1),(Wood,1)])
    [freeAttack 5 , freeDefend 1]

train:Card
train = Card "Train" TMove
    (payL [(Iron,3),(Wood,1)])
    [woodMove 1 3,scrapFor Wood 5 ] 


bow:Card
bow = Card "Bow" TAttack
    (payEq 1 [Wood,Iron])
    [Job (Pay Wood 1) [Gain Food 3]
    ,Job (Pay Food 3) [Attack 3]
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
