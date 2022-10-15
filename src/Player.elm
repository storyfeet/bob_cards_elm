module Player exposing (..)

import Cards exposing (Card)
import Decks.Starter as DS
import Job exposing (..)
import Dict exposing (Dict)

startRes : List (Resource, Int) -> Job
startRes = 
    List.map (\(r,n) -> gain r n) 

standardRes : Job
standardRes = startRes [(Gold,1),(Iron,1),(Wood,1),(Food,3)]

type alias Player =
    { name : String
    , difficulty : Int
    , handSize : Int
    , startItems : Job
    , jobs : List Job.Job
    , startCards : List ( Card, Int )
    }

type alias ReqList = Dict String (Card,List Int)

players : List Player
players = [jakeWilder,blazeDecker,caseyRocks,samBoater,jebSteal]


reqCard : Card -> Int -> ReqList-> ReqList
reqCard c n list= 
    let 
        (_,cl) = Dict.get c.name list |> Maybe.withDefault (c,[])
    in
        Dict.insert c.name (c,n::cl) list

reqPlayer : Player -> ReqList ->  ReqList
reqPlayer p rl = List.foldl (\(c,n) ls -> reqCard c n ls ) rl p.startCards

reqPlayers : List Player -> ReqList -> ReqList
reqPlayers pl rl =
    List.foldl (reqPlayer) rl pl

reqList : Int -> List (Card, Int)
reqList n =
    reqPlayers players Dict.empty
    |> Dict.values 
    |> List.map (\(c,v) ->(c, List.sort v |> List.reverse |> List.take n |> List.sum))
--    |> List.map (\(c,v) -> (cme,v))


jakeWilder : Player
jakeWilder =
    Player "Jake Wilder" 1 6
        standardRes
        [ [ discard, Move (N 1) ]
        , [ Scrap TAny (N 1) ]
        , [ Discard (TDanger DAny) (N 2) ]
        ]
        (DS.basicDeck )


blazeDecker : Player
blazeDecker =
    Player "Blaze Decker" 1 6
        standardRes
        [ [ Take (TDanger Exhaustion) (N 1), Move (N 1) ]
        , [ Discard TAny (X 1), Draw (X 1) ]
        , [ Pay Any (X 1), Scrap TAny (X 2) ]
        ]
        (DS.basicDeck)


caseyRocks : Player
caseyRocks =
    Player "Casey Rocks" 1 6
        (startRes [(Gold,2 ), (Food,5)])
        [ [ Discard TAny (N 1), MountainMove (N 1) ]
        , [ pay Food 1, Move (N 1) ]
        , [ Scrap TAny (N 1), Scrap (TDanger DAny) (N 1) ]
        ]
        (DS.minerDeck)

samBoater : Player
samBoater =
    Player "Sam Boater" 1 6
        standardRes  
        [ [ Draw (N 1), Scrap TAny (N 1) ]
        , [ In Water, Scrap (TDanger DAny) (X 1) ]
        , [ Pay Any (N 1), WaterMove (N 1), Move (N 1) ]
        ]
        (DS.sailorDeck)


jebSteal : Player
jebSteal =
    Player "Jeb Steal" 6 2
        standardRes 
        [ [ Take (TDanger Exhaustion) (N 1), Move (N 1) ]
        , [ pay Any 1, Discard (TDanger DAny) (N 1) ]
        ]
        (DS.basicDeck)
