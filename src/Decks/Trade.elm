module Decks.Trade exposing (..)
import Cards exposing (..)
import Job exposing (..)


tradeDeck : List (Card,Int)
tradeDeck = explorerDeck ++ diggerDeck ++ fighterDeck

-- Explorer Deck --


explorerDeck : List (Card,Int)
explorerDeck = 
    [ (horse, 3)
    , (stalion, 2)
    , (cow, 3)
    , (wagon, 2)
    , (train, 2)
    ]

potion :  Card
potion = Card "Potion" TFood (pay Food 1)
    [freebie (DiscardDanger (N 1))
    ,Job ScrapC  [(DiscardDanger (X 1))]
    ]

elixer : Card
elixer = Card "Elixer" TFood (payEq 1 [Food,Wood] )
    [free [DiscardDanger (N 1),Draw (N 1) ]]


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
    (And [pay Wood 4,pay Food 2]  )
    [ Job ScrapC [gain Wood 2,gain Food 2,draw 2]
    , Job Free [gain Wood 1, gain Food 1, draw 1]
    ]

train : Card
train = Card "Train" TMove
    (payL [(Iron,3),(Wood,1)])
    [woodMove 1 3,scrapFor Wood 5 ] 

-- Digger Deck -- 
diggerDeck : List (Card,Int)
diggerDeck = 
    [ (bigPan ,2)
    , (drill , 2)
    , (ironHammer , 2)
    , (jackHammer , 2)
    ]

bigPan : Card
bigPan = Card "Big Pan" TGold (In Village (pay Gold 1))
    [riverGather Gold 3]
drill : Card
drill = Card "Dril" TIron (In Village (And [pay Iron 2,pay Gold 1 ]))
    [Job (In Mountain (discard 1)) [gather Iron 5]]

ironHammer : Card 
ironHammer = Card "Iron Hammer" TGold (pay Iron 2)
    [Job (And [pay Iron 1, pay Wood 1,discard 1] ) [BuildRail] ]

jackHammer : Card
jackHammer = Card "Jack Hammer" TGold (In Village (pay Gold 2))
    [Job (And [pay Iron 1, pay Wood 2] ) [BuildRail] ]

-- Fighter Deck -- 
fighterDeck : List (Card,Int)
fighterDeck =
    [ (sword ,2 )
    , (shield, 2)
    , (twinSwords, 2)
    , (crossbow,2)
    ]


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

crossbow:Card
crossbow = Card "Crossbow" TAttack (And [pay Wood 3,pay Iron 2])
    [Job (pay Wood 1) [attack 5]]





