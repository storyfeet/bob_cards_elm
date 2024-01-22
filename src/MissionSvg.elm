module MissionSvg exposing (..)
import MissionSetup as MP
import PageSvg exposing (..)
import JobSvg as JSV
import Mission as MS
import MLists as ML
import JobString as JString
import ColorCodes as CC
import Config
import MLists exposing (ruleWrap)

front : MS.Mission -> String
front cam = 
    let 
        jrules = cam.jobs 
            |> List.map (JString.jobToString)
            |> ML.ruleWrap 50 
        --rules = MLists.mergeIfSmaller 7 cam.rules jrules
        crules = cam.rules |> ML.ruleWrap 34
    in 
        String.join "\n"
            [ rect 0 0 200 90 [flStk CC.orange "white" 1,rxy 2 2] 
            , rect 0 0 200 90 [flNoStk "white", opacity 0.5] 
            , rect 4 9 192 78 [flNoStk "White" , fprop "opacity" 0.4 ]
            , text "Arial" 5 [xy 4 7,flStk "Black" "white" 0.8,bold,strokeFirst
        ] cam.name
            , text "Arial" 5 [xy 185 7,flStk "Black" "white" 0.8,bold,strokeFirst
        ,txRight] ((difficultyStr cam.difficulty) ++ " Mission - " ++ (MP.modeStr cam.mode))
            , JSV.jobsSquish 75 10 70 72 cam.jobs
            , JSV.picItem 186 2 "difficulty" cam.difficulty "red"
            , textLines 5 14 4.5 [font "Arial" 4 ,txSpaces] crules
            , textLines 5 (14 + 4.6 * (List.length crules|> toFloat )) 3.5 [font "Arial" 3,txSpaces] jrules
            , gShift 131 14 [ -- Day and Night Phases
                text "Arial" 4.5 [xy 0 0,bold] "Day Phase"
                , dayPhase cam.mode |> ML.ruleWrap 34   |> textLines 2 5 4.3 [font "Arial" 3.8 ,txSpaces] 
                , text "Arial" 4.5 [xy 0 27.4,bold] "Night Phase"
                , textLines 2 32 4.3 [font "Arial" 3.8 ,txSpaces] cam.night
            ]

            ]

back : MS.Mission -> String
back cam =  
    let 
        df = if cam.mode == MP.Coop then
                [MP.Score cam.mode,MP.DayForward]
            else
                [MP.Score cam.mode]
        sup = df ++ cam.setup 
        fboard = case cam.boards of
            h::_ ->h
            [] -> "0"

    in
    String.join "\n"
        [ rect -2 -2 204 94 [flNoStk CC.emeraldGreen ] 
        , rect -2 -2 204 94 [flNoStk "White" , opacity 0.5 ]
        , rect 4 9 192 78 [flNoStk "White" , opacity 0.5 ]
        , text "Arial" 5 [xy 4 7,flStk "Black" "white" 0.8,bold,strokeFirst
    ] (cam.name ++ " - setup")
        , gShift 162 0 [ -- Options Section
            text "Arial" 5 [xy 0 15, bold] "Options"
            , text "Arial" 4 [xy 9 20] "Scoreboard"
            , text "Arial" 4 [xy 0 39, txCenter,rotate -90 0 39] "Bandit Dice"
            , namedCheckGrid 4 25 cam.boards ["d20","d12","Both"] 
            , [firstTimeOptions fboard] |> ML.ruleWrap 30 |> textLines 14 55 3.9 [font "Arial" 3,prop "font-style" "italic",txCenter] 
        ]
        , rect 93 9 64 78 [flNoStk "white"]
        , setupPic 119 14.5 34 43 "base"
        , sup |> List.map setupToPic |> gShift 90 15 
        , sup |>List.map MP.setupStr |>  ML.ruleWrap 52 |> textLines 8 15 5.3 [font "Arial" 3.7,txSpaces] 
        , gTrans [translate [113,58], scale [0.151,0.151]] [(front cam)]
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
                setupPic (29 - w) 9 w 35 s 
        MP.Wagon n -> 
            let
                d  = 6 * toFloat n  
            in 
                setupPic (25 - d) 26 4 3 "wagon_counter"
        MP.OneMeeple -> setupPic 24 23 5 4 "meeple_1"
        MP.TwoMeeples -> setupPic 24 23 5 4 "meeple_2"
        MP.ThreeMeeples -> setupPic 24 23 5 4 "meeple_3"
        MP.Score MP.Versus -> setupPic 44 5 5 4 "meeple_3"
        MP.Score _ -> setupPic 44 5 5 4 "meeple_white"
        MP.Bandits l -> l |> List.map (\x -> setupPic (26 - 6*(toFloat x)) 24 2.5 2.5 "bandit")   |> String.join "\n"
        MP.DayForward -> setupPic 52 9 3 6 "day_forward" 
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


dayPhase : MP.Mode -> List String 
dayPhase m = 
    let 
        refresh = "Refresh all Character Cards" 
        hlimit = "Players draw cards to Hand Limit"
        vturns = "Players take turns to perform jobs/actions" 
        cturns = "Players perform jobs/actions in any order"
        mdiscard = "Players may discard Item Cards"
    in
        case m of
            MP.Solo -> [
                "Refresh Character Card"
                , "Draw to Hand limit"
                , "Perform jobs/actions"
                , "May discard Item Cards"
                ]
            MP.Coop -> [refresh,hlimit,cturns,mdiscard]
            MP.Versus -> [refresh,hlimit,vturns,mdiscard]

firstTimeOptions : String -> String
firstTimeOptions n =  "If this is your first time, use Scoreboard '" ++ n ++ "', and a d20 bandit dice for an easier shorter game"


