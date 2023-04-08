module MissionSvg exposing (..)
import PageSvg exposing (..)
import JobSvg as JSV
import Mission as MS
import MLists
import JobString as JString
import ColorCodes as CC

front : MS.Mission -> String
front cam = 
    let 
        jrules = cam.jobs 
            |> List.map (JString.jobToString)
            |> ruleWrap 50 
        --rules = MLists.mergeIfSmaller 7 cam.rules jrules
        crules = cam.rules |> ruleWrap 37
    in 
        String.join "\n"
            [ rect 0 0 200 72 [flStk CC.orange "white" 1,rxy 2 2] 
            , rect 0 0 200 72 [flNoStk "white", opacity 0.5] 
            , rect 4 9 192 59 [flNoStk "White" , fprop "opacity" 0.4 ]
            , text "Arial" 5 [xy 4 7,flStk "Black" "white" 0.8,bold,strokeFirst
        ] cam.name
            , text "Arial" 5 [xy 196 7,flStk "Black" "white" 0.8,bold,strokeFirst
        ,txRight] (MS.modeStr cam.mode)
            , JSV.jobsSquish 80 10 80 62 cam.jobs
            , JSV.picItem 186 10 "difficulty" cam.difficulty "red"
            , textLines 5 14 4.6 [font "Arial" 4 ,txSpaces] crules
            , textLines 5 (14 + 4.6 * (List.length crules|> toFloat )) 3.5 [font "Arial" 3,txSpaces] jrules
            , text "Arial" 5 [xy 147 14,bold] "Night Phase"
            , textLines 147 20 4.6 [font "Arial" 4 ,txSpaces] cam.night
            ]

back : MS.Mission -> String
back cam =  
    String.join "\n"
        [ rect -2 -2 204 76 [flNoStk CC.emeraldGreen ] 
        , rect -2 -2 204 76 [flNoStk "White" , opacity 0.5 ]
        , rect 4 9 192 59 [flNoStk "White" , opacity 0.5 ]
        , text "Arial" 5 [xy 4 7,flStk "Black" "white" 0.8,bold,strokeFirst
    ] (cam.name ++ " - setup")
        , rect 45 9 66 59 [flNoStk "white"]
        , text "Arial" 4 [xy 15 15] "Boards"
        , text "Arial" 4 [xy 7 30, txCenter,rotate -90 7 30]  "Dice"
        , namedCheckGrid 8 20 cam.boards ["d20","d12","d8"]
        , setupPic cam.setupPic
        , cam.setup |> ruleWrap 40 |> textLines 112 15 6 [font "Arial" 4,txSpaces] 
        ]

setupPic : String -> String
setupPic fname =
    case fname of
        "" -> ""
        s -> img 45 10 66 54 ("../pics/setups/" ++ s ++ ".svg") []


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

ruleWrap : Int -> List String -> List String
ruleWrap n l =
    l |> List.map (MLists.capFirst)
        |> List.map (MLists.wordWrap "    " n )
        |> List.concat
