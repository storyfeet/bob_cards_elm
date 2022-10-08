module Decks.Starter exposing (starterDeck,playerDeck,dangerDeck)
import Cards exposing (..)
import Job exposing (..)
--STARTER CARDS

starterDeck :Int -> List (Card,Int)
starterDeck n = 
    [(pan, 2 * n )
    ,(boots,2 * n )
    ,(knife,2 * n)
    ,(rookieTrader ,2 * n)
    ,(saw,2 * n)
    ,(pickaxe,n)
    ,(mallet,n)
    ]

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
    [[In Mountain,discard , gather Iron 3]]

mallet : Card
mallet = Card "Mallet" TMake [starter 1]
    [[pay Gold 1,pay Iron 1, pay Wood 1,discard ,BuildRail]]

-- Danger 

dangerDeck :Int ->  List (Card,Int)
dangerDeck n =
    [(thirst,1 + 2* n)
    ,(hunger,1 + 2* n)
    ,(exhaustion,2 + 2 * n)
    ,(dysentery,2)
    ,(owie,2 + 2 * n)
    ,(legWound,2 + 2 * n)
    ,(armWound,2 + 2* n)
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
    ]

legWound : Card
legWound =  Card "Leg Wound" (TDanger Pain) []
    [ [ Discard (TMove) (N 1) ,discardD]
    , [In Village,Discard (TMove) (N 1) ,scrapD]
    ]

armWound : Card
armWound =  Card "Arm Wound" (TDanger Pain) []
    [[ discard ,discardD ]
    , [In Village,Discard (TGather) (N 1) ,scrapD]
    ]


-- Players
playerDeck : List (Card,Int)
playerDeck = 
    [(noobyNorris,2),(beginnerBen, 1),(climberCarl,1) ,(sailorSam ,1), (stealySteve,1)]
noobyNorris : Card 
noobyNorris = Card "Nooby Norris" (TPlayer 1) []
    [ [discard , Move (N 1)]
    , [Scrap TAny (N 1)]
    , [Discard (TDanger DAny) (N 2)]
    ]

beginnerBen : Card
beginnerBen = Card "Beginner Ben" (TPlayer 1)[]
    [ [Take (TDanger Exhaustion) (N 1), Move (N 1)]
    , [Discard TAny (X 1),Draw (X 1)]
    , [Pay Any (X 1),Scrap TAny (X 2)]
    ]

climberCarl : Card
climberCarl = Card "Climber Carl" (TPlayer 1) []
    [ [Draw (N 1)] 
    , [Discard TAny (N 1) , MountainMove (N 1)]
    , [Scrap TAny (N 1), Scrap (TDanger DAny) (N 1)]
    ]

sailorSam : Card
sailorSam = Card "Sailor Sam" (TPlayer 1) []
    [ [Draw (N 1),Scrap TAny (N 1)]
    , [In Water, Scrap (TDanger DAny) (X 1) ]
    , [Pay Any (N 1), WaterMove (N 1) , Move (N 1) ]
    ]

stealySteve : Card
stealySteve = Card "Stealy Steve" (TPlayer 2) []
    [ [Take (TDanger Exhaustion) (N 1) ,Move (N 1)]
    , [pay Any 1, Discard (TDanger DAny) (N 1)]
    ]





