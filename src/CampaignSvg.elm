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
        , textLines 5 15 6 [font "Arial" 4] cam.rules
        ]

back : CP.Campaign -> String
back cam =  
    String.join "\n"
        [ rect -3 -3 106 96 [flNoStk "#dddddd" ] 
        , rect 4 9 92 77 [flNoStk "White" , fprop "opacity" 0.4 ]
        , text "Arial" 5 [xy 4 7,flStk "Black" "white" 0.8,bold,strokeFirst
    ] (cam.name ++ " - setup")
        , rect 30 10 66 34 [flNoStk "white"]
        , rect 50 10 46 54 [flNoStk "white"]
        , text "Arial" 4 [xy 15 15] "Boards"
        , text "Arial" 4 [xy 7 30, txCenter,rotate -90 7 30]  "Dice"
        , namedCheckGrid 8 20 cam.boards ["d20","d12","d8"]
        , setupPic cam.setupPic
        , textLines 5 55 6 [font "Arial" 4] cam.setup
        ]

setupPic : String -> String
setupPic fname =
    case fname of
        "" -> ""
        s -> img 30 10 66 54 ("../pics/setups/" ++ s ++ ".svg") []


namedCheckGrid : Float -> Float -> List String -> List String -> String
namedCheckGrid x y ac dw =
    let
        acc = List.indexedMap (\i s -> text "Arial" 4 [xy (8 + 2.5 + x + (toFloat i) * 7  ) y, txCenter ] s ) ac |> String.join "\n"
        dww = List.indexedMap (\i s -> text "Arial" 4 [xy (7 + x) (5 + y + (toFloat i) * 7  ) ,txRight] s ) dw |> String.join "\n"
        cg = checkGrid (x + 8) (y + 1) ac dw
    in 
        String.join "\n" [acc,dww,cg]


checkGrid : Float -> Float -> List a -> List b -> String
checkGrid x y ac dw =
    dw |> List.indexedMap (\i _ -> checkRow x (y + (toFloat i) * 7) ac)
    |> String.join "\n"

checkRow : Float -> Float -> List a -> String
checkRow x y l =
    l |> List.indexedMap (\i _ -> rect (x + (toFloat i) * 7) y 5 5 [flStk "white" "black" 0.5,rxy 0.1 0.1])
    |> String.join "\n"

