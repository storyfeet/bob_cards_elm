module Player exposing (..)

import Job exposing (..)
import Cards exposing(Card)
import Decks.Starter as DS

type alias Player =
    { name : String
    , difficulty : Int
    , startItems : Job
    , jobs : List Job.Job
    , startCards : List (Int ,Card)
    }


jakeWilder : Player 
jakeWilder = Player "Jake Wilder" 1 []
    [ [discard , Move (N 1)]
    , [Scrap TAny (N 1)]
    , [Discard (TDanger DAny) (N 2)]
    ] []

blazeDecker : Card
blazeDecker = Card "Blaze Decker" (TPlayer 1)[]
    [ [Take (TDanger Exhaustion) (N 1), Move (N 1)]
    , [Discard TAny (X 1),Draw (X 1)]
    , [Pay Any (X 1),Scrap TAny (X 2)]
    ]

caseyRocks : Card
caseyRocks = Card "Casey Rocks" (TPlayer 1) []
    [ [Discard TAny (N 1),MountainMove (N 1) ] 
    , [pay Food 1,Move (N 1)]
    , [Scrap TAny (N 1), Scrap (TDanger DAny) (N 1)]
    ]

samBoater : Card
samBoater = Card "Sam Boater" (TPlayer 1) []
    [ [Draw (N 1),Scrap TAny (N 1)]
    , [In Water, Scrap (TDanger DAny) (X 1) ]
    , [Pay Any (N 1), WaterMove (N 1) , Move (N 1) ]
    ]

jebSteal : Card
jebSteal = Card "Jeb Steal" (TPlayer 2) []
    [ [Take (TDanger Exhaustion) (N 1) ,Move (N 1)]
    , [pay Any 1, Discard (TDanger DAny) (N 1)]
    ]



