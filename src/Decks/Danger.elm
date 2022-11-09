module Decks.Danger exposing (dangerDeck)
import Job exposing (..)
import Cards exposing(Card)
dangerDeck :Int ->  List (Card,Int)
dangerDeck n =
    [(thirst,1 + 2* n)
    ,(hunger,1 + 2* n)
    ,(exhaustion,1 + 2 * n)
    ,(dysentery,2)
    ,(owie,1 + 2 * n)
    ,(legWound,1 + 2 * n)
    ,(armWound,1 + 2* n)
    ]

thirst :Card
thirst = Card "Thirst" (TDanger Exhaustion) []
    [ [In River,discardD]
    , [In River,discard,scrapD]
    ]

hunger : Card
hunger = Card "Hunger" (TDanger Exhaustion) []
    [ [pay Any 1,discardD]
    , [pay Food 1,discard,scrapD]
    ]

exhaustion : Card
exhaustion = Card "Exhaustion" (TDanger Exhaustion) [] 
    [ [discard ,discardD]
    , [Discard TAny (N 2) ,scrapD]
    ]

dysentery : Card
dysentery = Card "Dysentery" (TDanger Exhaustion) []
    [
        [In River, Pay Food (N 1) ,scrapD]
    ]

owie : Card
owie = Card "Owie" (TDanger Pain) []
    [ [pay Food 1,discardD]
    , [In Village,pay Gold 1,scrapD]
    , [Discard (TGather) (N 1),Discard (TMove) (N 1) ,scrapD]
    ]

legWound : Card
legWound =  Card "Leg Wound" (TDanger Pain) []
    [ [ Discard (TMove) (N 1) ,discardD]
    , [ Discard (TMove) (N 2) ,scrapD]
    , [In Village,Discard (TMove) (N 1) ,scrapD]
    ]

armWound : Card
armWound =  Card "Arm Wound" (TDanger Pain) []
    [[ discard ,discardD ]
    , [In Village,Discard (TGather) (N 1) ,scrapD]
    , [Discard (TGather) (N 2) ,scrapD]
    ]


