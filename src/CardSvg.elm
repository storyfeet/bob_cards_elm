module CardSvg exposing (..)
import PageSvg exposing (..)
import Cards exposing (..)


front :  Card -> List String
front card =
    [ rect 0 0 60 80 [flstk (cTypeColor card.ctype) "none" 0]
    ]
    
    

