module PlayerSvg exposing (front,back)
import Player as PL
import PageSvg exposing (..)

front : PL.Player -> String
front p = 
    String.join "\n"
        [ rect 0 0 100 90 [flStk "lightBlue" "black" 1] 
        , rect 3 8 94 79 [flNoStk "White" , fprop "opacity" 0.4 ]
        , text "Arial" 5 [xy 2 6,flStk "Black" "white" 0.8,bold,strokeFirst
    ] p.name
        ]

back : PL.Player -> String
back p = 
    String.join "\n"
        [ rect 0 0 100 90 [flStk "lightGreen" "black" 1] 
        , rect 3 8 94 79 [flNoStk "White" , fprop "opacity" 0.4 ]
        , text "Arial" 5 [xy 2 6,flStk "Black" "white" 0.8,bold,strokeFirst
    ] ( p.name ++ " - setup")
        ]
