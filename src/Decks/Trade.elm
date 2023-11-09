module Decks.Trade exposing (tradeDeck,explorerDeck,diggerDeck,fighterDeck,cow,horse,climbingBoots,net,axe,huntingKnife,revolver,bigPan)
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
    , (whiskey, 3)
    , (elixer , 3)
    , (canoe ,2)
    , (sailboat , 2)
    , (climbingBoots ,2)
    , (forager, 2)
    , (fishingRod, 2)
    , (net, 2)
    , (huntingKnife, 2)
    ]

whiskey :  Card
whiskey = Card "Whiskey" THealth [[pay Food 1],[scrap TAny 1]]
    [[Discard (TDanger DAny) (X 1)]
    , [Scrap THealth This ,Scrap (TDanger DAny) (X 1)]
    ]

elixer : Card
elixer = Card "Elixer" THealth [payEq 1 [Food,Wood] , [In Village, pay Any 1 ]]
    [ [Scrap (TDanger DAny) (N 1), Draw (N 1) ]
    , [Scrap THealth This,Scrap (TDanger DAny) (X 1),Draw (X 1) ]
    ]


horse: Card
horse = Card "Horse" TMove
    [[In Prairie, pay Food 3],[ In Village ,pay Gold 1]]
    [ foodMove 1 2
    , scrapFor TMove Food 5
    ]
    

stalion:Card
stalion = Card "Stalion" TMove 
    [[In Prairie ,pay Food 4],[In Village ,pay Gold 2]]
    [ [scrapThis (TMove),Move (N 3),gain Food 2]
    , scrapFor TMove Food 6
    , [ Pay Food (X 2), Move (X 3)]
    ]

cow: Card
cow = Card "Cow" THealth 
    [[In Prairie ,pay Food 2],[ In Village ,pay Gold 1]]
    [ [gain Food 2] 
    , [In River,gain Food 3] 
    , [ scrapThis THealth, gain Food 5 ]
    ]


wagon:Card
wagon = Card "Wagon" THealth
    [[pay Wood 3,pay Food 2],[In Village, pay Gold 2]  ]
    [ [scrapThis THealth ,gain Wood 2,gain Food 2,draw 2]
    , [gain Wood 1, gain Food 1, draw 1]
    ]

canoe: Card
canoe = Card "Canoe" TMove
    [[pay Wood 2],[In Village, pay Gold 1]]
    [ [pay Food 1 ,WaterMove (N 1)]
    ]

sailboat: Card
sailboat = Card "Sailboat" TMove
    [[pay Wood 3, pay Any 1],[In Village, pay Gold 2, Discard TAny (N 1)]]
    [[WaterMove (N 2)]]

climbingBoots: Card 
climbingBoots = Card "Climbing Boots" TMove
    [[pay Metal 1],[pay Any 1,Discard TAny (N 2)]]
    [ [pay Food 1,discard ,Move (N 1)]
    , [pay Food 1, MountainMove (N 1)]
    ]

binoculars: Card
binoculars = Card "Binoculars" TMove
    [[pay Metal 1],[In Village, pay Any 2]]
    [ [Reveal (N 1)]
    , [scrapThis TMove, Reveal (N 2)]
    ]

telescope: Card
telescope = Card "Telescope" TMove
    [[pay Metal 1,pay Wood 1],[scrap TMove 1]]
    [ [ Reveal (N 2) ]
    , [scrapThis TMove, Reveal (N 3)]
    ]

fishingRod : Card
fishingRod = Card "Fishing Rod" TGather
    [[pay Wood 1,Discard TAny (N 2)]]
    [ [In River,gather Food 1]
    , [In Water,gather Food 3]]

net: Card
net = Card "Net" TGather
    [[pay Wood 2],[In River,scrap TAny 1,discard ]]
    [ [In Water, gather Food 5]
    , [In River, gather Food 2]
    , [discard,gather Food 1]
    ]

huntingKnife : Card
huntingKnife = Card "Hunting Knife" TGather
    [[pay Wood 1, pay Metal 1],[In Village, pay Gold 1]]
    [ [defend 1, attack 2]
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
    , (skilledTrader,2)
    ]

bigPan : Card
bigPan = Card "Big Pan" TGather [[In Village,pay Gold 1],[ discard,pay Wood 1]]
    [riverGather Gold 3]

axe : Card 
axe = Card "Axe" TGather [[pay Wood 1,pay Metal 1],[In Village, pay Gold 1]]
    [ [In Forest,pay Food 1,gain Wood 3 ]
    , [attack 2,defend 2]
    ]

twoManSaw : Card
twoManSaw = Card "Two Man Saw" TGather [[pay Metal 2],[scrap TGather 1,pay Any 2]]
    [ [In Forest,Discard TAny (N 2), gather Wood 5]
    ]

drill : Card
drill = Card "Drill" TGather [[In Village, pay Metal 1,pay Gold 1],[pay Metal 2,pay Any 1 ]]
    [[In Mountain, discard , gather Metal 5]]

lumpHammer : Card 
lumpHammer = Card "Lump Hammer" TMake [[pay Metal 2]]
    [[pay Metal 1, pay Wood 1,discard ,BuildRail] 
    ,[pay Metal 2, pay Wood 1,discard ,BuildBridge] ]

sledgeHammer : Card
sledgeHammer = Card "Sledgehammer" TMake [[In Village ,pay Gold 2]]
    [ [pay Metal 1, pay Wood 2,BuildRail]
    , [pay Metal 2, pay Wood 2,BuildBridge]
    , [In Mountain,Discard TAny (X 1),Gain Metal (XD 1)]
    ]

skilledTrader : Card 
skilledTrader = Card "Skilled Trader" TTrade [[pay Any 2,pay Any 2]]
    [ [discard, Pay Any (X 1),Gain Any (X 1)]
    , [In Village, Pay Any (X 1),Gain Any (X 1)]] 

trader : Card
trader = Card "Trader"  TTrade [[pay Gold 2]]
    [[discard, Pay Any (X 1),Gain Any (X 1)]] 

roamingTrader: Card
roamingTrader = Card "Roaming Trader" TTrade [ [pay Gold 2]]
    [ [Pay Gold (X 1), Gain Any (X 1)]
    , [Pay Any (X 2), Gain Any (X 1)]
    ]

forager : Card
forager = Card "Forager" TTrade [[In Forest,pay Any 2]]
    [[Scrap TAny (X 1), Draw (X 2)]
    ,[In Forest, Scrap (TDanger DAny) (N 2) ]] 

gambler : Card
gambler = Card "Gambler" TTrade [[In Village, pay Gold 1]]
    [ [Pay Gold (X 1),Gain Gold (XD 2)]
    , [Discard TAny (X 1), Draw (XD 2)]
    ]


-- Fighter Deck -- 
fighterDeck : List (Card,Int)
fighterDeck =
    [ (dagger ,2 )
    , (bow ,2)
    , (rifle, 2)
    , (dillinger,2)
    , (revolver,2)
    , (crossbow,2)
    ]


{-- sword:Card
sword = Card "Sword" TFight
    (payEq 1 [Metal,Wood])
    [ [attack 3]
    , [defend 3]
    , [In Forest,gather Food 1]
    ]
    --}

dagger : Card
dagger = Card "Dagger" TFight
    [[pay Metal 1,discard]]
    [ [discard, gather Food 2]
    , [discard , defend 3, attack 4]
    ]


bow:Card
bow = Card "Bow" TFight
    [[pay Wood 1]]
    [[In Forest, pay Wood 1, gather Food 4]
    ,[pay Wood 1,defend 2, attack 4]
    ]

dillinger: Card
dillinger= Card "Dillinger" TFight [[pay Wood 1,pay Metal 1]]
    [[attack 1 ,defend 4]]


revolver: Card 
revolver = Card "Revolver" TFight [[pay Metal 1, pay Wood 2]]
    [ [Pay Wood (X 1), Attack (XD 3)]
    , [In Forest,Pay Wood (X 1), Gain Food (XD 2)]
    , [defend 4]
    ]



rifle : Card
rifle = Card "Rifle" TFight [[In Village, pay Metal 1, pay Gold 1]]
    [[pay Metal 1, Attack (N 3), attack 4 ]
    , [pay Metal 1, Defend (N 3), attack 4]
    , [In Forest,gather Food 1]
    ]


crossbow:Card
crossbow = Card "Crossbow" TFight [[pay Wood 1,pay Metal 1]]
    [[pay Wood 1,defend 2,attack 5]
    , [In Forest, pay Wood 1, gather Food 2]
    ]


