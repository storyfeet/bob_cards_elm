module MissionSvg exposing (..)
import MissionSetup as MP
import PageSvg exposing (..)
import JobSvg as JSV
import Mission as MS
import MLists
import JobString as JString
import ColorCodes as CC
import Config

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
            [ rect 0 0 200 90 [flStk CC.orange "white" 1,rxy 2 2] 
            , rect 0 0 200 90 [flNoStk "white", opacity 0.5] 
            , rect 4 9 192 78 [flNoStk "White" , fprop "opacity" 0.4 ]
            , text "Arial" 5 [xy 4 7,flStk "Black" "white" 0.8,bold,strokeFirst
        ] cam.name
            , text "Arial" 5 [xy 196 7,flStk "Black" "white" 0.8,bold,strokeFirst
        ,txRight] ((difficultyStr cam.difficulty) ++ " Mission - " ++ (MP.modeStr cam.mode))
            , JSV.jobsSquish 80 10 70 72 cam.jobs
            , JSV.picItem 186 10 "difficulty" cam.difficulty "red"
            , textLines 5 14 4.6 [font "Arial" 4 ,txSpaces] crules
            , textLines 5 (14 + 4.6 * (List.length crules|> toFloat )) 3.5 [font "Arial" 3,txSpaces] jrules
            , text "Arial" 5 [xy 147 14,bold] "Night Phase"
            , textLines 147 20 4.6 [font "Arial" 4 ,txSpaces] cam.night
            ]

back : MS.Mission -> String
back cam =  
    let 
        df = if cam.mode == MP.Coop then
                [MP.Score cam.mode,MP.DayForward]
            else
                [MP.Score cam.mode]
        sup = df ++ cam.setup 
    in
    String.join "\n"
        [ rect -2 -2 204 94 [flNoStk CC.emeraldGreen ] 
        , rect -2 -2 204 94 [flNoStk "White" , opacity 0.5 ]
        , rect 4 9 192 78 [flNoStk "White" , opacity 0.5 ]
        , text "Arial" 5 [xy 4 7,flStk "Black" "white" 0.8,bold,strokeFirst
    ] (cam.name ++ " - setup")
        , rect 38 9 66 59 [flNoStk "white"]
        , text "Arial" 5 [xy 8 15, bold] "Options"
        , text "Arial" 4 [xy 15 25] "Scoreboard"
        , text "Arial" 4 [xy 8 40, txCenter,rotate -90 8 40] "Bandit Dice"
        , namedCheckGrid 10 30 cam.boards ["d20","d12","Both"] 
        , setupPic 50 15 50 50 "base"
        , sup |> List.map setupToPic |> String.join "\n"
        , sup |>List.map MP.setupStr |>  ruleWrap 52 |> textLines 108 15 5.3 [font "Arial" 3.7,txSpaces] 
        , text "Arial" 4 [xy 4.5 85,flNoStk "black",opacity 0.6] Config.version
        ]


setupPic : Float -> Float -> Float -> Float ->  String -> String
setupPic x y w h fname =
    case fname of
        "" -> ""
        s -> img x y w h ("../pics/setups/" ++ s ++ ".svg") []

setupToPic : MP.Setup -> String
setupToPic sp =
    case sp of
        MP.Grid n -> 
            let 
                w  = 7 * toFloat n + 2
                s = "grid_" ++ String.fromInt n ++ "x3"
            in 
                setupPic (65 - w) 19 w 35 s 
        MP.Wagon n -> 
            let
                d  = 6 * toFloat n  
            in 
                setupPic (61 - d) 36 4 3 "wagon_counter"
        MP.OneMeeple -> setupPic 60 33 5 4 "meeple_1"
        MP.TwoMeeples -> setupPic 60 33 5 4 "meeple_2"
        MP.ThreeMeeples -> setupPic 60 33 5 4 "meeple_3"
        MP.Score MP.Versus -> setupPic 80 15 5 4 "meeple_3"
        MP.Score _ -> setupPic 80 15 5 4 "meeple_white"
        MP.Bandits l -> l |> List.map (\x -> setupPic (61 - 6*(toFloat x)) 34 2.5 2.5 "bandit")   |> String.join "\n"
        MP.DayForward -> setupPic 88 19 3 6 "day_forward" 
        _ -> ""
        


difficultyStr : Int -> String
difficultyStr n =
    case n of
        1 -> "Beginner"
        2 -> "Tricky"
        3 -> "Hard"
        4 -> "Very Hard"
        _ -> "Level " ++ (String.fromInt n)

namedCheckGrid : Float -> Float -> List String -> List String -> String
namedCheckGrid x y ac dw =
    let
        acc = List.indexedMap (\i s -> text "Arial" 4 [xy (9 + 2.5 + x + (toFloat i) * 9  ) y, txCenter ] s ) ac |> String.join "\n"
        dww = List.indexedMap (\i s -> text "Arial" 4 [xy (7 + x) (6 + y + (toFloat i) * 9  ) ,txRight] s ) dw |> String.join "\n"
        cg = checkGrid (x + 8) (y + 1) 9 ac dw
    in 
        String.join "\n" [acc,dww,cg]


checkGrid : Float -> Float -> Float -> List a -> List b -> String
checkGrid x y sz ac dw =
    dw |> List.indexedMap (\i _ -> checkRow x (y + (toFloat i) * sz) sz ac)
    |> String.join "\n"

checkRow : Float -> Float -> Float -> List a -> String
checkRow x y sz l =
    l |> List.indexedMap (\i _ -> rect (x + (toFloat i) * sz) y (sz * 0.8) (sz * 0.8)  [flStk "white" "black" 0.5,rxy 0.1 0.1])
    |> String.join "\n"

ruleWrap : Int -> List String -> List String
ruleWrap n l =
    l |> List.map (MLists.capFirst)
        |> List.map (MLists.wordWrap "    " n )
        |> List.concat
