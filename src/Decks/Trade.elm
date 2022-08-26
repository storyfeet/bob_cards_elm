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
potion = Card "Potion" TGather [pay Food 1]
    [[Discard (TDanger DAny) (N 1)]
    , [Scrap TAny This ,Discard (TDanger DAny) (X 1)]
    ]

elixer : Card
elixer = Card "Elixer" TGather (payEq 1 [Food,Wood] )
    [[Discard (TDanger DAny) (N 1),Draw (N 1) ]]


horse: Card
horse = Card "Horse" TMove
    [In Prarie, pay Food 3,Or, In Village ,pay Gold 1]
    [foodMove 1 2, scrapFor Food 5]
    

stalion:Card
stalion = Card "Stalion" TMove 
    [In Prarie ,pay Food 4,Or, In Village ,pay Gold 2]
    [[ Pay Food (X 2), Move (X 3)]
    , scrapFor Food 6
    ]

cow: Card
cow = Card "Cow" THealth 
    [In Prarie ,pay Food 2,Or, In Village ,pay Gold 1]
    [ [gain Food 2] 
    , scrapFor Food 5 
    ]


wagon:Card
wagon = Card "Wagon" TMove
    [pay Wood 4,pay Food 2]  
    [ [scrapMe ,gain Wood 2,gain Food 2,draw 2]
    , [gain Wood 1, gain Food 1, draw 1]
    ]

train : Card
train = Card "Train" TMove
    [pay Iron 3,pay Wood 1 ]
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
bigPan = Card "Big Pan" TGather [In Village,pay Gold 1]
    [riverGather Gold 3]
drill : Card
drill = Card "Dril" TGather [In Village, pay Iron 2,pay Gold 1 ]
    [[In Mountain, discard , gather Iron 5]]

ironHammer : Card 
ironHammer = Card "Iron Hammer" TMake [pay Iron 2]
    [[pay Iron 1, pay Wood 1,discard ,BuildRail] ]

jackHammer : Card
jackHammer = Card "Jack Hammer" TMake [In Village ,pay Gold 2]
    [[pay Iron 1, pay Wood 2,BuildRail] ]

-- Fighter Deck -- 
fighterDeck : List (Card,Int)
fighterDeck =
    [ (sword ,2 )
    , (shield, 2)
    , (twinSwords, 2)
    , (crossbow,2)
    ]


sword:Card
sword = Card "Sword" TFight
    (payEq 1 [Iron,Wood])
    [[attack 5] , [defend 2]]

twinSwords:Card
twinSwords = Card "Twin Swords" TFight 
    (payEq 2 [Iron, Wood]) 
    [[attack 8],[ defend 4]]

shield: Card
shield = Card "Shield" TFight
    [pay Iron 1]
    [[defend 4],[attack 1]]

crossbow:Card
crossbow = Card "Crossbow" TFight [pay Wood 3,pay Iron 2]
    [[pay Wood 1,attack 5]]





