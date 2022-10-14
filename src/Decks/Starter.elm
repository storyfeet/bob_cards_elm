module Decks.Starter exposing (..)
import Cards exposing (..)
import Job exposing (..)
import Decks.Trade as Trd
--STARTER CARDS

basicDeck :List (Card,Int)
basicDeck = 
    [(pan, 2 )
    ,(boots,2)
    ,(knife,2)
    ,(rookieTrader ,2)
    ,(saw,2 )
    ,(pickaxe,1)
    ,(mallet,1)
    ]

farmerDeck : List (Card, Int)
farmerDeck = [(pan, 2 )
    , (toStarter Trd.horse , 1)
    , (toStarter Trd.cow , 1)
    , (boots ,1)
    , (rookieTrader , 1)
    , (knife ,1)
    , (saw,3)
    , (pickaxe, 1)
    , (mallet,  1)
    ] 

minerDeck : List (Card, Int)
minerDeck =
    [(pan, 2 )
    ,(toStarter Trd.climbingBoots,2)
    ,(knife,1)
    ,(rookieTrader ,2)
    ,(saw,2 )
    ,(pickaxe,2)
    ,(mallet,1)
    ]


toStarter: Card -> Card
toStarter c = 
    {c | cost = [starter]}

pan : Card
pan = Card "Pan" TGather [starter] [riverGather Gold 1]



knife : Card
knife = Card "Knife" TGather [starter] 
    [ [discard, gather Food 1]
    , [In Forest , gather Food 2]
    , [defend 1, attack 2]
    ]


saw:Card
saw = Card "Saw" TGather 
    [starter] 
    [ [In Forest , discard , Gain Wood (D 2)] 
    ]


boots : Card
boots = Card "Boots" TMove [starter] 
    [foodMove 1 1]

rookieTrader : Card
rookieTrader = Card "Rookie Trader" TTrade [starter]
    [ [In Village ,Pay Gold (X 1), Gain Any (X 1)]
    , [In Village ,Pay Any (X 2), Gain Any (X 1)]
    , [discard,Pay Any (X 2), Gain Any (X 1)]
    ]

pickaxe : Card
pickaxe = Card "Pickaxe" TGather [starter]
    [[In Mountain,discard , gather Iron 2]]

mallet : Card
mallet = Card "Mallet" TMake [starter]
    [[pay Gold 1,pay Iron 1, pay Wood 1,discard ,BuildRail]]

