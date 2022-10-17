module PlayerSvg exposing (front,back)
import Player as PL
import PageSvg exposing (..)
import CardSvg exposing (job,jobs,narrowStk)

front : PL.Player -> String
front p = 
    String.join "\n"
        [ rect 0 0 100 90 [flStk "lightBlue" "white" 1] 
        , rect 4 9 92 77 [flNoStk "White" , fprop "opacity" 0.4 ]
        , text "Arial" 5 [xy 4 7,flStk "Black" "white" 0.8,bold,strokeFirst
    ] p.name
        , text "Arial" 4 [xy 7 50 , txCenter , rotate -90 7 50,narrowStk "black" "white" ] "Draw"
        , text "Arial" 4 [xy 93 50 , txCenter , rotate 90 93 50,narrowStk "black" "white" ] "Discard"
        , jobs 9 85 p.jobs
        ]

back : PL.Player -> String
back p = 
    String.join "\n"
        [ rect -3 -3 106 96 [flNoStk "lightGreen" ] 
        , rect 4 9 92 77 [flNoStk "White" , fprop "opacity" 0.4 ]
        , text "Arial" 5 [xy 4 7,flStk "Black" "white" 0.8,bold,strokeFirst ] ( p.name ++ " - setup")
        , text "Arial" 4 [xy 10 14,flStk "Black" "none" 0,bold] "Start Resources"
        , job 6 15 p.startItems 
        , text "Arial" 4 [xy 10 30,flStk "Black" "none" 0,bold] "Start Cards"
        , p.startCards |> List.indexedMap (\i (c ,n) -> text "Arial" 4 [xy 10 ((toFloat i) * 6 + 36)] (String.fromInt n ++ " * " ++ c.name) ) |> String.join "\n"

        ]
