module CardSvg exposing (..)
import PageSvg exposing (..)
import Cards exposing (..)
import Job exposing (..)


front :  Card -> String
front card =
    String.join "\n" [ rect 0 0 50 70 [flStk (cTypeColor card.ctype) "none" 0]
    , rect 5 5 40 60 [flNoStk "White" , prop "opacity" "0.5" ]
    , text "Arial" 6 [xy 20 10,narrowStk "Black" "yellow" ,txCenter] card.name
    , costOrType card.cost card.ctype
    , jobs 55 card.jobs
    ]

jobs : Float -> List Job -> String
jobs y l =
    case l of 
        [] -> ""
        h::t -> job 5 y h ++ jobs (y - 12) t -- (if splitJob h then 20 else 10) ) 


job : Float -> Float -> Job -> String
job x y jb =
    case jb of
        [] -> ""
        h::t -> action x y h ++ job (x + 10 ) y t 



jobLen : Job -> Float
jobLen j = 10 * List.length j |> toFloat

action : Float -> Float -> Action -> String
action x y c = 
    case c of 
        In p -> place x y p 
        Or -> ""
        Discard ct n -> jobCard x y ct "-" "orange" n 
        Draw n -> jobCard x y TAny "+" "green" n
        Scrap ct n -> jobCard x y ct "#" "red" n
        Take ct n -> jobCard x y ct "^" "blue" n
        Starter n -> jobStar x y "white"  n
        Player -> jobStar x y "blue" Job.This
        Move n -> jobCircle x y "Pink" "Mv" n
        Attack n -> jobCircle x y "red" "Atk" n
        Defend n -> jobCircle x y "Grey" "Dfd" n
        Pay r n -> resource x y r "Red" "-" n 
        Gain r n -> resource x y r "Green" "+" n 
        Gather r n -> jobCircle x y (resourceColor r) (resourceShortName r) n
        BuildRail -> jobCircle x y "Orange" "Bld" (N 1)

            
costOrType : Job -> CardType -> String
costOrType j ct =
    case j of
        [] -> cardType ct
        _ -> cost 2 38 2 j

cost : Float -> Float -> Float -> Job -> String
cost top x y c = 
    case c of 
        [] -> ""
        Or::t -> cost (top+10) (x - 12) (top + 10 ) t
        h::t -> action x y h ++ cost top x (y+10 ) t

cardType : CardType -> String
cardType ct = 
    case ct of
        TDanger d ->  
            String.join "\n" 
                [ qStar 38 2 "black" "white"
                , idText 43 10 "red" (dangerType d)
            ]
        _ -> qStar 38 2 (cTypeColor ct) "black"



resource : Float -> Float ->Resource -> String -> String -> JobNum -> String
resource x y r tcol sym n =
    String.join "\n" 
        [ rect x y 10 10 [narrowStk (resourceColor r) "black"] 
        , gainText (x + 5) (y + 5) tcol (sym ++ jnum n)
        , jobText (x + 5) (y + 9) (resourceShortName r)
        ]

narrowStk: String -> String -> String 
narrowStk f s = 
    String.join " " 
    [ flStk f s 0.5
    , strokeFirst
    ]



jobCard : Float -> Float -> CardType -> String -> String -> JobNum -> String
jobCard x y ct tx tcol n =
    String.join "\n" 
         [ rect (x+2) y 6 10 
            [narrowStk (cTypeColor ct) "black"
            , rxy 1 1
            , rotate 30 (x + 5) (y+5 )   
            ]        
        , cardLetter (x + 1) (y + 9) ct
        , gainText (x + 6.5) (y+5) tcol (tx ++ jnum n)

        ]

cardLetter : Float -> Float -> CardType -> String
cardLetter x y ct =
    case ct of
        TDanger d -> idText x y "black" (dangerType d)
        _ -> ""

jobArrow : Float -> Float -> String 
jobArrow x y =
    polygon (jobArrowPoints x y 7 7) [narrowStk "red" "white" ,prop "class" "arrow"]

jobCorner : Float -> Float -> String
jobCorner x y =
    etag "path" 
    [ prop "d" (String.join " " (jobCornerPath x y 8 8))
    , narrowStk "red" "white" 
    , prop "class" "arrow"
    ]

        
jobCircle : Float -> Float -> String -> String -> JobNum -> String
jobCircle x y col tx n = 
    String.join "\n" 
        [ circle (x+5) (y+5) 5 [narrowStk col "Black"  ]
        , jobTextn x y tx n
        ]


jobRect : Float -> Float -> String -> String -> JobNum -> String
jobRect x y col tx n = 
    String.join "\n" 
        [ rect x y 10 10 [narrowStk col "Black"  ]
        , jobTextn x y tx n
        ]

jobStar : Float -> Float -> String ->  JobNum -> String
jobStar x y col n =
    String.join "\n"
        [ qStar x y col "black"
        , jobText (x+5) (y + 6) (jnum n)
        ]

qStar : Float -> Float -> String -> String -> String
qStar  x y col oline= 
    polygon (starPoints x y 10 10) [narrowStk col oline]

dangerStar : Float -> Float -> String -> String -> JobNum -> String
dangerStar x y col tx n =
    String.join "\n"
        [ polygon (starPoints x y 10 10) [narrowStk col "black" ]
        , idText (x+ 2.5) ( y+7) "grey" (tx)
        , case n of 
            Job.None -> ""
            _ -> gainText (x + 5) (y + 4 ) "Green" ("+" ++ jnum n)
        ]


place : Float -> Float -> Place ->  String
place x y p =
    String.join "\n" 
        [ polygon (hexPoints x y 10 10) [narrowStk (placeColor p) "black" ]
        , jobText (x + 5) (y + 4) (placeShortName p)
        ]


hexPoints: Float -> Float -> Float -> Float -> List Float
hexPoints x y w h =
    let
        y1 = y + h*0.3
        y2 = y + h*0.7
        y3 = y + h
        x1 = x + w*0.5
        x2 = x+ w
    in
        [ x1,y 
        , x2, y1
        , x2, y2
        , x1, y3
        , x , y2
        , x , y1
        ]

starPoints : Float -> Float -> Float -> Float ->  List Float 
starPoints x y w h =
    let 
         xx = (\n -> x + w * n * 0.1)
         yy = (\n -> y + h * n * 0.1)
    in
        [ xx 5 , y  -- top
        , xx 6 , yy 3
        , xx 10 , yy 3 -- top right
        , xx 6.5 , yy 6
        , xx 8 , yy 10 -- bottom right
        , xx 5 , yy 8
        , xx 2 , yy 10 -- bottom left
        , xx 3.5 , yy 6
        , x , yy 3 -- top left
        , xx 4, yy 3
        ]

jobArrowPoints : Float -> Float -> Float -> Float -> List Float
jobArrowPoints x y w h =
    let 
         xx = (\n -> x + w * n * 0.1)
         yy = (\n -> y + h * n * 0.1)
    in 
        [ x , yy 5 
        , xx 6 , yy 4
        , xx 5 , yy 2
        , xx 10 , yy 5
        , xx 5 , yy 8
        , xx 6 , yy 6
        ]

jobCornerPath : Float -> Float -> Float -> Float -> List String
jobCornerPath x y w h =
    let
        xx = (\n -> String.fromFloat (x + w * n * 0.1))
        yy = (\n -> String.fromFloat (y + h * n * 0.1))

    in
        [ "M", xx 0 , yy 0 -- back
        , "Q", xx 0, yy 5 , xx 7, yy 6
        , "L", xx 6,yy 4 
        , "L", xx 10, yy 7 -- Point
        , "L", xx 6, yy 10
        , "L", xx 7, yy 8
        , "Q", xx 0, yy 8 , xx 0 , yy 0 --finish
        ]



jobTextn : Float -> Float -> String ->JobNum -> String
jobTextn x y tx n = 
    String.join "\n" 
        [ jobText (x + 5) (y + 4) (tx)
        , jobText (x + 5) (y + 9) (jnum n)
        ]

jobText : Float -> Float -> String -> String
jobText x y str = text "Arial" 4 [xy x y,txCenter,flNoStk "black" ] str

idText : Float -> Float -> String -> String -> String
idText x y col tx =
        text "Arial" 6 [xy x y ,flStk col "white" 0.5, strokeFirst,bold,txCenter] (tx )

gainText : Float -> Float -> String -> String -> String
gainText x y col tx =
        text "Arial" 5 [xy x y ,flStk col "white" 0.5, strokeFirst,bold,txCenter] (tx )

