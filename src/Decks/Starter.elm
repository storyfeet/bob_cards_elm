module Decks.Starter exposing (..)
import Cards exposing (..)
import Job exposing (..)
import Decks.Trade as Trd
--STARTER CARDS

basicDeck :Int -> List (Card,Int)
basicDeck n = 
    [(pan, 2 * n )
    ,(boots,2 * n )
    ,(knife,2 * n)
    ,(rookieTrader ,2 * n)
    ,(saw,2 * n)
    ,(pickaxe,n)
    ,(mallet,n)
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

toStarter: Card -> Card
toStarter c = 
    {c | cost = [starter 1]}

pan : Card
pan = Card "Pan" TGather [starter 2] [riverGather Gold 1]



knife : Card
knife = Card "Knife" TGather [starter 2] 
    [ [discard, gather Food 1]
    , [In Forest , gather Food 2]
    , [defend 1, attack 2]
    ]


saw:Card
saw = Card "Saw" TGather 
    [starter 2] 
    [ [In Forest , discard , Gain Wood (D 2)] 
    ]


boots : Card
boots = Card "Boots" TMove [starter 2] 
    [foodMove 1 1]

rookieTrader : Card
rookieTrader = Card "Rookie Trader" TTrade [starter 2]
    [ [In Village ,Pay Gold (X 1), Gain Any (X 1)]
    , [In Village ,Pay Any (X 2), Gain Any (X 1)]
    , [discard,Pay Any (X 2), Gain Any (X 1)]
    ]

pickaxe : Card
pickaxe = Card "Pickaxe" TGather [starter 1]
    [[In Mountain,discard , gather Iron 2]]

mallet : Card
mallet = Card "Mallet" TMake [starter 1]
    [[pay Gold 1,pay Iron 1, pay Wood 1,discard ,BuildRail]]

