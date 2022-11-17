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
back p =  
    String.join "\n"
        [ rect -3 -3 106 96 [flNoStk "#ccccff" ] 
        , rect 4 9 92 77 [flNoStk "White" , fprop "opacity" 0.4 ]
        , text "Arial" 5 [xy 4 7,flStk "Black" "white" 0.8,bold,strokeFirst ] ( p.name ++ " - setup")
        , text "Arial" 4 [xy 5 14,flStk "Black" "none" 0,bold] "Start Resources"
        , text "Arial" 4 [xy 5 30,flStk "Black" "none" 0,bold] "Start Cards"
        , text "Arial" 4 [xy 55 14, bold] "Bandit Phase"
        ]

