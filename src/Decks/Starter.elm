module Decks.Starter exposing (..)
import Cards exposing (..)
import Job exposing (..)
import Decks.Trade as Trd
--STARTER CARDS


coreDeck :List (Card,Int)
coreDeck = 
    [(boots,2)
    ,(pan, 2 )
    ,(knife,2)
    ,(saw,2 )
    ,(pickaxe,1)
    ,(rookieTrader ,1)
    ,(mallet,1)
    ]

coreMinus: List Card -> List (Card ,Int)
coreMinus l =
    coreDeck |> List.filter (\(c,_) -> not (List.member c l))

coreMinPlus : List Card -> List (Card, Int) -> List (Card, Int)
coreMinPlus min plus = coreMinus min ++ (List.map (\(c,n) -> (toStarter c, n)) plus)

basicDeck :List (Card,Int)
basicDeck =  
    coreMinPlus [rookieTrader] [(rookieTrader , 2)]


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



sailorDeck : List (Card, Int)
sailorDeck =
    [ (pan,2)
    ,(boots,2)
    ,(toStarter Trd.net,2)
    ,(rookieTrader ,2)
    ,(saw,2 )
    ,(pickaxe,1)
    ,(mallet,1)
    ]

toStarter: Card -> Card
toStarter c = 
    {c | cost = []}

pan : Card
pan = Card "Pan" TGather [] [riverGather Gold 1]


knife : Card
knife = Card "Knife" TGather [] 
    [ [discard, gather Food 1]
    , [In Forest , gather Food 2]
    , [defend 1, attack 2]
    ]


saw:Card
saw = Card "Saw" TGather 
    [] 
    [ [In Forest , discard , Gain Wood (D 2)] 
    ]


boots : Card
boots = Card "Boots" TMove [] 
    [foodMove 1 1]

rookieTrader : Card
rookieTrader = Card "Rookie Trader" TTrade []
    [ [In Village ,Pay Gold (X 1), Gain Any (X 1)]
    , [In Village ,Pay Any (X 2), Gain Any (X 1)]
    , [discard,Pay Any (X 2), Gain Any (X 1)]
    ]

pickaxe : Card
pickaxe = Card "Pickaxe" TGather []
    [[In Mountain,discard , gather Metal 2]]

mallet : Card
mallet = Card "Mallet" TMake []
    [[pay Gold 1,pay Metal 1, pay Wood 1,discard ,BuildRail]]

