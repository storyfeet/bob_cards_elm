module CardSvg exposing (..)
import PageSvg exposing (..)
import Cards exposing (..)


front :  Card -> List String
front card =
    [ rect 0 0 50 70 [flStk (cTypeColor card.ctype) "none" 0]
    , rect 5 5 40 60 [flNoStk "White" , prop "opacity" "0.5" ]
    , text "Arial" 10 [xy 20 10,flStk "Black" "yellow" 0.5,strokeFirst,txCenter] card.name
    ]


--job : Float -> Job -> String
--job y jb =

costLen : Cost -> Int
costLen c =
    case c of
        In _ inner -> 1 + costLen inner
        Or l -> List.foldl (\i n ->n +costLen i ) 0 l
        And l -> List.foldl (\i n ->n +costLen i ) 0 l 
        Free -> 0
        _ -> 1

{--cost : Float-> Float -> Cost -> String
cost x y c = 
    case c of 
        In p inner -> 
            --}

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
        [ polygon [ x+5,y 
                  , x+10, y+3
                  , x+10, y+7
                  , x+ 5, y+10
                  , x , y+7
                  , x , y+3
                  ] [flStk (placeColor p) "black" 1]
        , resText (x + 5) (y + 4) (placeShortName p)
        ]


resText : Float -> Float -> String -> String
resText x y str = text "Arial" 4 [xy x y,txCenter,flNoStk "black" ] str

