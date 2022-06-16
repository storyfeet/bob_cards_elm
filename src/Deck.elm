module Deck exposing(..)
import MRand exposing(..)

type alias Deck crd=
    { hand : List crd
    , draw : List crd
    , discard : List crd
    }

draw : NGen ->Int -> Deck crd -> (NGen,Deck crd)
draw gg n d =
    case (d.draw, d.discard) of
        ([], [])-> (d,NGen)
        ([], ds) -> 
            let 
                (gg1,ndraw) = MLists.shuffleInner gg ds
                
            in 
                draw n {
                    d | draw = ndraw ,discard = []
                }
            


     


