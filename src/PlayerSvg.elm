module PlayerSvg exposing (front,back)
import Player as PL
import PageSvg exposing (..)
import CardSvg  as CSV exposing (job,jobs,narrowStk)
import HasPicList as PicLists
import Cards 

front : PL.Player -> String
front p = 
    String.join "\n"
        [ rect 0 0 100 90 [flStk "#ffb380" "white" 1] 
        , rect 4 9 92 77 [flNoStk "White" , fprop "opacity" 0.4 ]
        , text "Arial" 5 [xy 4 7,flStk "Black" "white" 0.8,bold,strokeFirst
    ] p.name
        , facePic 4 9 92 23 p.name
        , text "Arial" 4 [xy 7 50 , txCenter , rotate -90 7 50,narrowStk "black" "white" ] "Draw"
        , text "Arial" 4 [xy 93 50 , txCenter , rotate 90 93 50,narrowStk "black" "white" ] "Discard"
        , jobs 9 85 p.jobs
        , picItem 75 2 "difficulty" p.difficulty "red"
        , picItem 85 2 "hand_size" p.handSize "Blue"
        , text "Arial" 4 [xy 50 54, bold] "Player Phase"
        , playerPhase p.handSize |> textLines 50 60 6 [font "Arial" 4]
        ]

back : PL.Player -> String
back p =  
    String.join "\n"
        [ rect -3 -3 106 96 [flNoStk "lightGreen" ] 
        , rect 4 9 92 77 [flNoStk "White" , fprop "opacity" 0.4 ]
        , text "Arial" 5 [xy 4 7,flStk "Black" "white" 0.8,bold,strokeFirst ] ( p.name ++ " - setup")
        , text "Arial" 4 [xy 5 14,flStk "Black" "none" 0,bold] "Start Resources"
        , job 5 15.5 p.startItems 
        , text "Arial" 4 [xy 5 30,flStk "Black" "none" 0,bold] "Start Cards"
        , p.startCards 
        |> List.map (\(c, n) -> String.fromInt n ++ " * " ++ c.name)
        |> textLines 5 36 6 [font "Arial" 4]
        , text "Arial" 4 [xy 55 14, bold] "Bandit Phase"
        , banditPhase|> textLines 55 20 6 [font "Arial" 4]
        ]

picItem : Float -> Float -> String -> Int -> String -> String
picItem x y picName num col =
    String.join "\n" [
         CSV.jobPic x y picName 
        , text "Arial" 5 [xy (x + 5) (y + 4), CSV.narrowStk col "white" , bold ] (String.fromInt num)
        ]

playerPhase : Int ->  List String
playerPhase hSize = 
    [ "Untap this card"
    , "Draw to "++ (String.fromInt hSize ) ++ " Cards"
    ,"Pass P1 Token"
    ,"Play Cards / Trade"
    , "May discard Item Cards"
    ]

banditPhase : List String
banditPhase = 
    [ "Move Bandit Tracker"
    , "Move Trade row"
    , "Take an 'E' Danger"
    , "Bandits attack"
    , "Bandits move"
    , "Remove tiles"
    , " (>5 east of all players)"
    , "Bandits Appear"
    ]


facePicFile: String -> Maybe String
facePicFile = Cards.imageFile PicLists.cList ".png" "../pics/characters/"


facePic: Float -> Float -> Float -> Float -> String -> String
facePic x y w h cname = 
    case  facePicFile cname of
        Just f -> img x y w h f []
        Nothing -> "" --Debug.log "Couldn't find thing" cname 
