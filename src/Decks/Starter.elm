module Decks.Starter exposing (..)
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
pan = Card "Pan" TGold (starter 2) [riverGather Gold 1]

bow:Card
bow = Card "Bow" TAttack
    (starter 2)
    [Job (In Forest (pay Wood 1)) [gather Food 3]
    ,Job (pay Wood 1) [attack 3]
    ]

saw:Card
saw = Card "Saw" TWood 
    (starter 2) 
    [ Job (In Forest (discard 1)) [gain Wood 3] 
    ]

boots : Card
boots = Card "Boots" TMove (starter 2) 
    [foodMove 1 1]

rookieTrader : Card
rookieTrader = Card "Rookie Trader" TGold (starter 2)
    [ Job (In Village (Pay Gold (X 1))) [Gain Any (X 1)]
    , Job (In Village (Pay Any (X 2))) [Gain Gold (X 1)]
    ]

pickaxe : Card
pickaxe = Card "Pickaxe" TGold (starter 1)
    [Job (In Mountain (discard 1)) [gather Iron 3]]

woodHammer : Card
woodHammer = Card "Wood Hammer" TGold (starter 1)
    [Job (And [pay Gold 1,pay Iron 1, pay Wood 1,discard 1] ) [BuildRail] ]

-- Danger 

dangerDeck : List (Card,Int)
dangerDeck =
    [(thirst,4)
    ,(hunger,4)
    ,(owie,6)
    ,(exhaustion,6)
    ]

thirst :Card
thirst = Card "Thirst" TDanger (Danger Lack Job.None)
    [Job (In River Free) [Job.ScrapB Job.This]]

hunger : Card
hunger = Card "Hunger" TDanger (Danger Lack Job.None)
    [Job (pay Food 1) [Job.ScrapB Job.This]]

owie : Card
owie = Card "Owie" TDanger (Danger Pain Job.None)
    [Job (In Village (pay Gold 1)) [Job.ScrapB Job.This]]

exhaustion : Card
exhaustion = Card "Exhaustion" TDanger (Danger Exhaustion Job.None)
    [Job (In Village (discard 1)) [Job.ScrapB Job.This]]
 



-- Players
playerDeck : List (Card,Int)
playerDeck =
    [(noobyNorris,1) , (stealySteve,1)]
noobyNorris : Card 
noobyNorris = Card "Nooby Norris" TPlayer (Player)
    [ Job Free [Movement (N 1)]
    , Job (In Village Free) [ GainStarter (N 1)]
    ]

stealySteve : Card
stealySteve = Card "Stealy Steve" TPlayer (Player)
    [ Job (Danger Lack (N 1)) [Movement (N 1)]]




