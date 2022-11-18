module CampaignSvg exposing (..)
import PageSvg exposing (..)
import JobSvg as JSV
import Campaign as CP

front : CP.Campaign -> String
front cam = 
    String.join "\n"
        [ rect 0 0 100 90 [flStk "#ffb380" "white" 1] 
        , rect 4 9 92 77 [flNoStk "White" , fprop "opacity" 0.4 ]
        , text "Arial" 5 [xy 4 7,flStk "Black" "white" 0.8,bold,strokeFirst
    ] cam.name
        , JSV.jobs 61 4.5 87 cam.jobs
        , JSV.picItem 75 2 "difficulty" cam.difficulty "red"
        ]

back : CP.Campaign -> String
back cam =  
    String.join "\n"
        [ rect -3 -3 106 96 [flNoStk "#ccccff" ] 
        , rect 4 9 92 77 [flNoStk "White" , fprop "opacity" 0.4 ]
        , text "Arial" 5 [xy 4 7,flStk "Black" "white" 0.8,bold,strokeFirst
    ] (cam.name ++ " - setup")
        , rect 30 10 66 34 [flNoStk "white"]
        , rect 50 10 46 54 [flNoStk "white"]
        , setupPic cam.setupPic
        , textLines 5 55 14 [font "Arial" 4] cam.setup
        ]

setupPic : String -> String
setupPic fname =
    case fname of
        "" -> ""
        s -> img 30 10 66 54 ("../pics/setups/" ++ s ++ ".svg") []

