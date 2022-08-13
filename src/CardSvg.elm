module CardSvg exposing (..)
import PageSvg exposing (..)
import Cards exposing (..)


front :  Card -> String
front card =
    String.join "\n" [ rect 0 0 50 70 [flStk (cTypeColor card.ctype) "none" 0]
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

cost : Float -> Float -> Cost -> String
cost x y c = 
    case c of 
        In p inner -> place x y p ++ cost (x+10 ) y inner
        Or [] -> ""
        Or (ic::[]) -> cost x y ic
        Or (h::t) -> cost x y h ++ cost (x + 4 + costLen h)  y (Or t)
        And [] -> ""
        And (h::t) -> cost x y h ++ cost (x + costLen h) y (And t)
        Discard n -> jobCard x y "yellow" "dsc" n 
        Pay r n -> resource x y r n 
        ScrapC  -> jobCard x y "red" "scp" 1
        Free -> ""
            

resource : Float -> Float ->Resource -> Int -> String
resource x y r n =
    String.join "\n" 
        [ rect x y 10 10 [flStk (resourceColor r) "black" 1] 
        , jobTextn x y (resourceShortName r) n
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
        _ -> ""
            
        
jobCard : Float -> Float -> String -> String -> Int -> String
jobCard x y col tx n =
    String.join "\n" 
         [ rect x y 6 10 
            [flStk col "black" 0
            , rxy 1 1
            , rotate 30 (x + 3) (y+5 )   
            ]        
        , jobTextn x y tx n
        ]

        
jobCircle : Float -> Float -> String -> String -> Int -> String
jobCircle x y col tx n = 
    String.join "\n" 
        [ circle (x+5) (y+5) 5 [flStk col "Black" 1 ]
        , jobTextn x y tx n
        ]

jobRect : Float -> Float -> String -> String -> Int -> String
jobRect x y col tx n = 
    String.join "\n" 
        [ rect x y 10 10 [flStk col "Black" 1 ]
        , jobTextn x y tx n
        ]

place : Float -> Float -> Place ->  String
place x y p =
    String.join "\n" 
        [ polygon (hexPoints x y 10 10) [flStk (placeColor p) "black" 1]
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

jobTextn : Float -> Float -> String ->Int -> String
jobTextn x y tx n = 
    String.join "\n" 
        [ jobText (x + 5) (y + 4) (tx)
        , jobText (x + 5) (y + 9) (String.fromInt n)
        ]

jobText : Float -> Float -> String -> String
jobText x y str = text "Arial" 4 [xy x y,txCenter,flNoStk "black" ] str

