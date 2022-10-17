module PlayerSvg exposing (front,back)
import Player as PL
import PageSvg exposing (..)
import CardSvg  as CSV exposing (job,jobs,narrowStk)

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
        , picItem 85 8 "Difficulty" "difficulty" p.difficulty "red"
        , picItem 85 20 "Hand Size" "hand_size" p.handSize "Blue"
        , text "Arial" 4 [xy 50 54, bold] "Player Phase"
        , ["Untap " ++ p.name,"Draw to "++ (String.fromInt p.handSize ) ++ " Cards","Pass P1 Token","Play Cards / Trade", "May discard Item Cards"]|> textLines 50 60 6 [font "Arial" 4]
        ]

picItem : Float -> Float -> String -> String -> Int -> String -> String
picItem x y tx picName num col =
    String.join "\n" [
        text "Arial" 4 [xy x (y + 5 ),flStk "Black" "none" 0,txRight] tx
        , CSV.jobPic x y picName 
        , text "Arial" 5 [xy (x + 5) (y + 4), CSV.narrowStk col "white" , bold ] (String.fromInt num)
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
        , p.startCards 
        |> List.map (\(c, n) -> c.name ++ " * " ++ String.fromInt n)
        |> textLines 10 36 6 [font "Arial" 4]


        ]



