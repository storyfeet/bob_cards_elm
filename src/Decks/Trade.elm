module Decks.Trade exposing (tradeDeck,explorerDeck,diggerDeck,fighterDeck,cow,horse,climbingBoots,net,axe)
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
    , (sailboat , 2)
    , (climbingBoots ,2)
    , (forager, 2)
    , (fishingRod, 2)
    , (net, 2)
    , (huntingKnife, 2)
    ]

potion :  Card
potion = Card "Potion" TGather [pay Food 1]
    [[Discard (TDanger DAny) (X 1)]
    , [Scrap TGather This ,Scrap (TDanger DAny) (X 1)]
    ]

elixer : Card
elixer = Card "Elixer" TGather (payEq 1 [Food,Wood] )
    [ [Scrap (TDanger DAny) (N 1), Draw (N 1) ]
    , [Scrap TGather This,Scrap (TDanger DAny) (X 1),Draw (X 1) ]
    ]


horse: Card
horse = Card "Horse" TMove
    [In Prairie, pay Food 3,Or, In Village ,pay Gold 1]
    [ foodMove 1 2
    , scrapFor TMove Food 5
    ]
    

stalion:Card
stalion = Card "Stalion" TMove 
    [In Prairie ,pay Food 4,Or, In Village ,pay Gold 2]
    [[ Pay Food (X 2), Move (X 3)]
    , scrapFor TMove Food 6
    ]

cow: Card
cow = Card "Cow" THealth 
    [In Prairie ,pay Food 2,Or, In Village ,pay Gold 1]
    [ [gain Food 2] 
    , [ scrapThis THealth, gain Food 5 ]
    ]


wagon:Card
wagon = Card "Wagon" TMove
    [pay Wood 4,pay Food 2]  
    [ [scrapThis TMove ,gain Wood 2,gain Food 2,draw 2]
    , [gain Wood 1, gain Food 1, draw 1]
    ]

canoe: Card
canoe = Card "Canoe" TMove
    [pay Wood 2]
    [ [pay Food 1 ,WaterMove (N 1)]
    ]

sailboat: Card
sailboat = Card "Sailboat" TMove
    [pay Wood 4]
    [[WaterMove (N 2)]]

climbingBoots: Card 
climbingBoots = Card "Climbing Boots" TMove
    [pay Iron 1]
    [ [pay Any 1,Move (N 1)]
    , [pay Food 1, MountainMove (N 1)]
    ]

binoculars: Card
binoculars = Card "Binoculars" TMove
    [pay Iron 1]
    [[Reveal (N 1) (N 1)]]

telescope: Card
telescope = Card "Telescope" TMove
    [pay Iron 1,pay Wood 1]
    [[Pay Any (X 1),Reveal (X 1) (N 2) ]]

fishingRod : Card
fishingRod = Card "Fishing Rod" TGather
    [pay Wood 1]
    [[In Water,gather Food 3]]

net: Card
net = Card "Net" TGather
    [pay Wood 2]
    [ [In Water, gather Food 5]
    , [discard,gather Food 1]
    ]

huntingKnife : Card
huntingKnife = Card "Hunting Knife" TGather
    [pay Wood 1, pay Iron 1]
    [ [defend 2, attack 3]
    , [In Forest, gather Food 4]
    , [discard, gather Food 2]
    ]

-- Digger Deck -- 
diggerDeck : List (Card,Int)
diggerDeck = 
    [ (bigPan ,2)
    , (drill , 2)
    , (axe, 2)
    , (twoManSaw, 2)
    , (lumpHammer , 2)
    , (sledgeHammer , 2)
    , (roamingTrader ,2)
    , (trader ,2)
    , (gambler,2)
    , (quickTrader,2)
    ]

bigPan : Card
bigPan = Card "Big Pan" TGather [In Village,pay Gold 1]
    [riverGather Gold 3]

axe : Card 
axe = Card "Axe" TGather [pay Wood 1,pay Iron 1]
    [ [In Forest,pay Food 1,gain Wood 3 ]
    , [attack 2,defend 2]
    ]

twoManSaw : Card
twoManSaw = Card "2 Man Saw" TGather [pay Iron 2]
    [ [In Forest,Discard TAny (N 2), gather Wood 5]
    ]

drill : Card
drill = Card "Dril" TGather [In Village, pay Iron 2,pay Gold 1 ]
    [[In Mountain, discard , gather Iron 5]]

lumpHammer : Card 
lumpHammer = Card "Lump Hammer" TMake [pay Iron 2]
    [[pay Iron 1, pay Wood 1,discard ,BuildRail] ]

sledgeHammer : Card
sledgeHammer = Card "Sledgehammer" TMake [In Village ,pay Gold 2]
    [ [pay Iron 1, pay Wood 2,BuildRail]
    , [Discard TAny (N 2),gather Iron 3]
    ]

quickTrader : Card 
quickTrader = Card "Quick Trader" TTrade [pay Any 2]
    [[discard, Pay Any (X 1),Gain Any (X 1)]]


trader : Card
trader = Card "Trader"  TTrade [pay Gold 2]
    [[In Village, Pay Any (X 1),Gain Any (X 1)]] 

roamingTrader: Card
roamingTrader = Card "Roaming Trader" TTrade  [pay Gold 2]
    [ [Pay Gold (X 1), Gain Any (X 1)]
    , [Pay Any (X 2), Gain Any (X 1)]
    ]

forager : Card
forager = Card "Forager" TTrade [In Forest,pay Any 2]
    [[Scrap TAny (X 1), Draw (X 2)]]

gambler : Card
gambler = Card "Gambler" TTrade [In Village, pay Gold 1]
    [ [Pay Gold (X 1),Gain Gold (XD 2)]
    ]


-- Fighter Deck -- 
fighterDeck : List (Card,Int)
fighterDeck =
    [ (sword ,2 )
    , (bow ,2)
    , (rifle, 2)
    , (dillinger,2)
    , (revolver,2)
    , (crossbow,2)
    ]


sword:Card
sword = Card "Sword" TFight
    (payEq 1 [Iron,Wood])
    [[attack 3] , [defend 3]]

bow:Card
bow = Card "Bow" TFight
    [pay Wood 1]
    [[In Forest, pay Wood 1, gather Food 3]
    ,[pay Wood 1,defend 2, attack 4]
    ]

dillinger: Card
dillinger= Card "Dillinger" TFight [pay Wood 1,pay Iron 1]
    [[attack 1 ,defend 4]]


revolver: Card 
revolver = Card "Revolver" TFight [pay Iron 1, pay Wood 2]
    [ [Pay Wood (X 1), Attack (XD 3)]
    , [defend 4]
    ]



rifle : Card
rifle = Card "Rifle" TFight [In Village, pay Iron 1, pay Gold 1]
    [[pay Iron 1, Attack (N 3), attack 4 ]
    , [pay Iron 1, Defend (N 3), attack 4]
    ]





crossbow:Card
crossbow = Card "Crossbow" TFight [pay Wood 1,pay Iron 1]
    [[pay Wood 1,attack 5]]


