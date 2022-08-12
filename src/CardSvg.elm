module CardSvg exposing (..)
import PageSvg exposing (..)
import Cards exposing (..)


front :  Card -> List String
front card =
    [ rect 0 0 50 70 [flStk (cTypeColor card.ctype) "none" 0]
    , rect 5 5 40 60 [flNoStk "White" , prop "opacity" "0.5" ]
    , text "Arial" 10 [xy 20 10,flStk "Black" "yellow" 0.5,strokeFirst,txCenter] card.name
    , jobs 55 card.jobs
    ]

jobs : Float -> List Job -> String
jobs y l =
    case l of 
        [] -> ""
        h::t -> job y h ++ jobs (y - 10 ) t

job : Float -> Job -> String
job y jb =
    cost 0 y jb.req

costLen : Cost -> Float
costLen c =
    case c of
        In _ inner -> 10 + costLen inner
        Or l -> List.foldl (\i n -> n +costLen i + 4) -4 l
        And l -> List.foldl (\i n -> n +costLen i ) 0 l 
        Free -> 0
        _ -> 10

cost : Float-> Float -> Cost -> String
cost x y c = 
    case c of 
        In p inner -> place x y p ++ cost (x+10 ) y inner
        Or [] -> ""
        Or (ic::[]) -> cost x y ic
        Or (h::t) -> cost x y h ++ cost (x + 4 + costLen h)  y (Or t)
        And [] -> ""
        And (h::t) -> cost x y h ++ cost (x + costLen h) y (And t)
        Discard n -> rect x y 6 10 [flStk "yellow" "black" 0,rxy 3 3  ] ++ text "Arial" 5 [xy 5 5] (String.fromInt n)
        Pay r n -> resource x y r n 
        ScrapC  -> rect x y 6 10 [flStk "red" "black" 0,rxy 3 3  ] 
        Free -> ""
            

resource : Float -> Float ->Resource -> Int -> String
resource x y r n =
    String.join "\n" 
        [ rect x y 10 10 [flStk (resourceColor r) "black" 1] 
        , resText (x + 5) (y + 4) (resourceShortName r)
        , resText (x + 5) (y + 9) (String.fromInt n)
        ]

place : Float -> Float -> Place ->  String
place x y p =
    String.join "\n" 
        [ polygon (hexPoints x y 10 10) [flStk (placeColor p) "black" 1]
        , resText (x + 5) (y + 4) (placeShortName p)
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


resText : Float -> Float -> String -> String
resText x y str = text "Arial" 4 [xy x y,txCenter,flNoStk "black" ] str

