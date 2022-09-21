module Decks.Trade exposing (tradeDeck,explorerDeck,diggerDeck,fighterDeck)
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
    , (telescope, 2)
    , (binoculars, 2)
    , (potion, 2)
    , (elixer , 2)
    , (canoe ,2)
    , (climbingBoots ,2)
    , (forager, 2)
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
    [In Prairie, pay Food 3,Or, In Village ,pay Gold 1]
    [foodMove 1 2, scrapFor Food 5]
    

stalion:Card
stalion = Card "Stalion" TMove 
    [In Prairie ,pay Food 4,Or, In Village ,pay Gold 2]
    [[ Pay Food (X 2), Move (X 3)]
    , scrapFor Food 6
    ]

cow: Card
cow = Card "Cow" THealth 
    [In Prairie ,pay Food 2,Or, In Village ,pay Gold 1]
    [ [gain Food 2] 
    , scrapFor Food 5 
    ]


wagon:Card
wagon = Card "Wagon" TMove
    [pay Wood 4,pay Food 2]  
    [ [scrapMe ,gain Wood 2,gain Food 2,draw 2]
    , [gain Wood 1, gain Food 1, draw 1]
    ]

canoe: Card
canoe = Card "Canoe" TMove
    [pay Wood 3]
    [[WaterMove]]

climbingBoots: Card 
climbingBoots = Card "Climbing Boots" TMove
    [pay Iron 1]
    [[MountainMove,Move (N 1)]]

binoculars: Card
binoculars = Card "Binocular" TMove
    [pay Iron 1]
    [[Reveal (N 1)]]

telescope: Card
telescope = Card "Telescope" TMove
    [pay Iron 1,pay Wood 1]
    [[Pay Any (X 1),Reveal (X 1)]]

-- Digger Deck -- 
diggerDeck : List (Card,Int)
diggerDeck = 
    [ (bigPan ,2)
    , (drill , 2)
    , (ironHammer , 2)
    , (jackHammer , 2)
    , (roamingTrader ,1)
    , (trader ,1)
    , (quickTrader,2)
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

quickTrader : Card 
quickTrader = Card "Quick Trader" TTrade [pay Any 3]
    [[In Village, Pay Any (X 2),Gain Any (X 1)]]


trader : Card
trader = Card "Trader"  TTrade [pay Gold 2]
    [[In Village, Pay Any (X 1),Gain Any (X 1)]] 

roamingTrader: Card
roamingTrader = Card "Roaming Trader" TTrade  [pay Gold 2]
    [ [Pay Gold (X 1), Gain Any (X 1)]
    , [Pay Any (X 3), Gain Any (X 1)]
    ]

forager : Card
forager = Card "Forager" TTrade [In Forest,pay Any 2]
    [[Scrap TAny (X 1), Draw (X 2)]]


-- Fighter Deck -- 
fighterDeck : List (Card,Int)
fighterDeck =
    [ (sword ,2 )
    , (shield, 2)
    , (bow ,2)
    , (rifle, 2)
    , (pistol,2)
    , (revolver,2)
    , (crossbow,1)
    ]


sword:Card
sword = Card "Sword" TFight
    (payEq 1 [Iron,Wood])
    [[attack 2] , [defend 2]]

bow:Card
bow = Card "Bow" TFight
    [pay Wood 1]
    [[In Forest, pay Wood 1, gather Food 3]
    ,[pay Wood 1,defend 1, attack 3]
    ]

pistol: Card
pistol= Card "Pistol" TFight [pay Iron 1]
    [[attack 1], [defend 3]]


revolver: Card 
revolver = Card "Revolver" TFight [pay Iron 1, pay Wood 2]
    [ [Pay Wood (X 1),Attack (XD 3)]
    , [defend 3]
    ]



rifle : Card
rifle = Card "Rifle" TFight [In Village, pay Iron 1, pay Gold 1]
    [[pay Iron 1, Attack (N 2), attack 4 ]
    , [pay Iron 1, Defend (N 2), attack 4]
    ]




shield: Card
shield = Card "Shield" TFight
    [pay Iron 1]
    [[defend 4],[attack 1]]

crossbow:Card
crossbow = Card "Crossbow" TFight [pay Wood 1,pay Iron 1]
    [[pay Wood 1,attack 5]]





