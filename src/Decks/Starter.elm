module Decks.Starter exposing (starterDeck,playerDeck,dangerDeck)
import Cards exposing (..)
import Job exposing (..)
--STARTER CARDS

starterDeck : List (Card,Int)
starterDeck = 
    [(pan,2)
    ,(boots,2)
    ,(bow,2)
    ,(rookieTrader ,2)
    ,(saw,2)
    ,(pickaxe,1)
    ,(woodHammer,1)
    ]
pan : Card
pan = Card "Pan" TGather [starter 2] [riverGather Gold 1]

bow:Card
bow = Card "Bow" TFight
    [starter 2]
    [[In Forest, pay Wood 1, gather Food 3]
    ,[pay Wood 1, attack 3]
    ]

saw:Card
saw = Card "Saw" TGather 
    [starter 2] 
    [ [In Forest , discard , gain Wood 3] 
    ]

boots : Card
boots = Card "Boots" TMove [starter 2] 
    [foodMove 1 1]

rookieTrader : Card
rookieTrader = Card "Rookie Trader" TTrade [starter 2]
    [ [In Village ,Pay Gold (X 1), Gain Any (X 1)]
    , [In Village ,Pay Any (X 2), Gain Gold (X 1)]
    ]

pickaxe : Card
pickaxe = Card "Pickaxe" TGather [starter 1]
    [[In Mountain,discard , gather Iron 3]]

woodHammer : Card
woodHammer = Card "Wood Hammer" TMake [starter 1]
    [[pay Gold 1,pay Iron 1, pay Wood 1,discard ,BuildRail]]

-- Danger 

dangerDeck : List (Card,Int)
dangerDeck =
    [(thirst,4)
    ,(hunger,4)
    ,(owie,6)
    ,(exhaustion,6)
    ,(legWound,4)
    ]

thirst :Card
thirst = Card "Thirst" (TDanger Lack) []
    [[In River,discard,scrapMe]]

hunger : Card
hunger = Card "Hunger" (TDanger Lack) []
    [[pay Food 1,discard,scrapMe]]

owie : Card
owie = Card "Owie" (TDanger Pain) []
    [[In Village,pay Gold 1,scrapMe]]

legWound : Card
legWound =  Card "Leg Wound" (TDanger Pain) []
    [[In Village,Discard (TMove) (N 1) ,scrapMe]]


exhaustion : Card
exhaustion = Card "Exhaustion" (TDanger Exhaustion) [] 
    [[Discard TAny (N 2) ,scrapMe]]
 



-- Players
playerDeck : List (Card,Int)
playerDeck = 
    [(noobyNorris,2),(beginnerBen, 2),(noviceNiles,2) , (stealySteve,2)]
noobyNorris : Card 
noobyNorris = Card "Nooby Norris" (TPlayer 1) []
    [ [Move (N 1)]
    , [In Village , Take TStarter (N 1)]
    , [Discard (TDanger DAny) (N 1)]
    ]

beginnerBen : Card
beginnerBen = Card "Beginner Ben" (TPlayer 1)[]
    [ [Draw (N 1)]
    , [Discard TAny (X 1),Draw (X 1)]
    , [pay Any 1,Scrap TAny (N 1)]
    ]

noviceNiles : Card
noviceNiles = Card "Novie Niles" (TPlayer 1) []
    [ [Draw (N 1)] 
    , [MountainMove]
    , [Discard (TDanger DAny) (N 1)]
    ]



stealySteve : Card
stealySteve = Card "Stealy Steve" (TPlayer 2) []
    [ [Take (TDanger Exhaustion) (N 1) ,Move (N 1)]
    , [pay Any 1, Discard (TDanger DAny) (N 1)]
    ]





