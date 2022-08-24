module CardSvg exposing (..)
import PageSvg exposing (..)
import Cards exposing (..)
import Job exposing (..)


front :  Card -> String
front card =
    String.join "\n" [ rect 0 0 50 70 [flStk (cTypeColor card.ctype) "none" 0]
    , rect 5 5 40 60 [flNoStk "White" , prop "opacity" "0.5" ]
    , text "Arial" 6 [xy 20 10,narrowStk "Black" "yellow" ,txCenter] card.name
    , vcost 38 2 card.cost
    , jobs 55 card.jobs
    ]

jobs : Float -> List Job -> String
jobs y l =
    case l of 
        [] -> ""
        h::t -> job y h ++ jobs (y - (if splitJob h then 20 else 10) ) t

splitJob : Job -> Bool 
splitJob j = benLen j.for + costLen j.req > 31  

job : Float -> Job -> String
job y jb =
    let 
        blen = benLen jb.for
        costY = if splitJob jb then y - 10 else y

        ja = if splitJob jb then
                    jobCorner (35 - blen) y
                else
                    jobArrow  ((costLen jb.req + (45 - blen) - 3)*0.5 ) y

    in 
        String.join "\n" 
            [cost 5 costY jb.req
            , ja
            , benefits 45 y jb.for
            ]


costLen : Cost -> Float
costLen c =
    case c of
        In _ inner -> 10 + costLen inner
        Or l -> List.foldl (\i n -> n +costLen i + 4) -4 l
        And l -> List.foldl (\i n -> n +costLen i ) 0 l 
        Free -> 0
        _ -> 10

cost : Float -> Float -> Cost -> String
cost x y c = 
    case c of 
        In p inner -> place x y p ++ cost (x+10 ) y inner
        Or [] -> ""
        Or (ic::[]) -> cost x y ic
        Or (h::t) -> cost x y h ++ cost (x + 4 + costLen h)  y (Or t)
        And [] -> ""
        And (h::t) -> cost x y h ++ cost (x + costLen h) y (And t)
        Discard n -> jobCard x y "lightblue" "-" "blue" n 
        Pay r n -> resource x y r n 
        ScrapC  -> jobCard x y "lightRed" "X" "red" Job.This
        Starter n -> jobStar x y "white"  n
        Free -> ""
            
vcost : Float -> Float -> Cost -> String
vcost x y c = 
    case c of 
        In p inner -> place x y p ++ vcost x (y+10) inner
        Or [] -> ""
        Or (ic::[]) -> vcost x y ic
        Or (h::t) -> vcost x y h ++ vcost (x - 12) (y + 10 )   (Or t)
        And [] -> ""
        And (h::t) -> vcost x y h ++ vcost x (y + costLen h) (And t)
        _ -> cost x y c

resource : Float -> Float ->Resource -> JobNum -> String
resource x y r n =
    String.join "\n" 
        [ rect x y 10 10 [narrowStk (resourceColor r) "black"] 
        , jobTextn x y (resourceShortName r) n
        ]

narrowStk: String -> String -> String 
narrowStk f s = 
    String.join " " 
    [ flStk f s 0.5
    , strokeFirst
    ]

benefits:Float -> Float -> List Benefit -> String 
benefits xend y bens = 
    let x = xend - (toFloat (10 * (List.length bens   )))
    in 
        bens 
        |> List.indexedMap (\n b -> benefit (x + (toFloat n* 10)) y b  )
        |> String.join "\n"
 


benefit : Float -> Float -> Benefit -> String
benefit x y b = 
    case b of 
        Movement n -> jobCircle x y "Pink" "Mv" n
        Attack n -> jobCircle x y "red" "Atk" n
        Defend n -> jobCircle x y "Grey" "Dfd" n
        Gain r n -> jobRect x y (resourceColor r) (resourceShortName r) n
        Draw n -> jobCard x y "lightblue" "+" "green" n
        Gather r n -> jobCircle x y (resourceColor r) (resourceShortName r) n
        ScrapB n -> jobCard x y "lightblue" "X" "red" n
        ScrapDanger n -> jobCard x y "grey" "X" "red" n
            
benLen : List Benefit -> Float
benLen l = toFloat (List.length l ) * 10
        
jobCard : Float -> Float -> String -> String -> String -> JobNum -> String
jobCard x y col tx tcol n =
    String.join "\n" 
         [ rect (x+2) y 6 10 
            [narrowStk col "white" 
            , rxy 1 1
            , rotate 30 (x + 5) (y+5 )   
            ]        
        , text "Arial" 6 [xy (x + 3) (y+6) ,flStk tcol "white" 0.5, strokeFirst,bold] (tx ++ jnum n)
        --, jobText (x + 5) (y + 9) (jnum n )
        ]


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
        [ polygon (starPoints x y 10 10) [narrowStk col "black" ]
        , jobText (x+5) (y + 6) (jnum n)
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

