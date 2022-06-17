module Deck exposing(..)
import MRand exposing(..)
import MLists

type alias Deck crd=
    { hand : List crd
    , draw : List crd
    , discard : List crd
    }

empty : Deck crd
empty= 
    {hand = []
    , draw = []
    , discard =[]
    }

draw : GGen ->Int -> Deck crd -> (GGen,Deck crd)
draw gg n d =
    case (d.draw, d.discard) of
        ([], [])-> (gg,d)
        ([], ds) -> 
            let 
                (gg1,ndraw,_) = MLists.shuffleInner gg ds
                
            in 
                draw gg1 n {
                    d | draw = ndraw ,discard = []
                }
        (h::t,_) -> draw gg (n - 1) {
                d | hand = h::d.hand , draw = t
            }
            

fromNCardList: GGen -> Int -> List (crd,Int)-> (GGen,Deck crd)
fromNCardList gg n ll = 
    let 
        (gg1 , sh ,_) = ll |> MLists.spreadL |> MLists.shuffleInner gg
    in 
        (gg1, fromCardList n sh)



fromCardList:Int -> List crd -> Deck crd
fromCardList n ls =
    Deck (List.take n ls) (List.drop n ls) []
     


