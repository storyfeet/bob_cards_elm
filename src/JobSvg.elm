module JobSvg exposing (..)
import Job as J exposing (Job)
import PageSvg exposing (..)
import Cards exposing (cTypeColor)

picItem : Float -> Float -> String -> Int -> String -> String
picItem x y picName num col =
    String.join "\n" [
         jobPic x y picName 
        , text "Arial" 5 [xy (x + 5) (y + 4), narrowStk col "white" , bold ] (String.fromInt num)
        ]
jobPic: Float -> Float -> String -> String
jobPic x y fname = 
    img x y 10 10 ("../pics/jobs/" ++ fname  ++ ".svg")[]

jobs : Float -> Float -> List Job -> String
jobs x y l =
    case l of 
        [] -> ""
        h::t -> job x (y - jobHeight h) h ++ jobs x (y - jobHeight h) t 


job : Float -> Float -> Job -> String
job x y jb = 
    List.indexedMap (jobPlaceAction x y) jb
    |> String.join "\n"
    

jobHeight : Job -> Float
jobHeight j = 
    jobLen j 
    |> floor
    |> \n -> (n // 41 ) + 1
    |> \a -> a * 12
    |> toFloat


jobLen : Job -> Float
jobLen j = 10 * List.length j |> toFloat

action : Float -> Float -> J.Action -> String
action x y c = 
    case c of 
        J.In p -> place x y p 
        J.Or -> ""
        J.Discard ct n -> jobCard x y ct "-" "orange" n 
        J.Draw n -> jobCard x y J.TAny "+" "green" n
        J.Scrap ct n -> jobCard x y ct "#" "red" n
        J.Take ct n -> jobCard x y ct "^" "blue" n
        J.Starter -> qStar x y "yellow" "black" --jobStar x y "yellow"  n
        J.Move n -> jobN x y "move" n
        J.Attack n -> jobN x y "attack" n
        J.Defend n -> jobN x y "defend" n
        J.WaterMove n -> jobN x y "sail" n
        J.MountainMove n -> jobN x y "climb" n
        J.Reveal n -> jobN x y "reveal" n
        J.Pay r n -> resource x y r "Red" "-" n 
        J.Gain r n -> resource x y r "Green" "+" n 
        J.BuildRail -> jobPic x y "build_rail"
        J.BuildBridge -> jobPic x y "build_bridge"
        J.Event e -> event e x y

on Job : J.Action

eventPic : J.Event -> String
eventPic e =
    case e of
        J.OnWagonEast -> "on_wagon_east"
        J.OnWagonWest -> "on_wagon_west"
        J.OnBarWest -> "on_bar_west"
        J.OnBuild -> "on_build"
        J.OnBuildWest -> "on build_west"
        J.OnReveal -> "on_reveal"
        J.OnRevealWest -> "on_reveal_west"
        J.OnDefeatBandits -> "on_defeat_bandits"

event : J.Event ->Float -> Float -> String
event e x y =
    eventPic e |> jobPic x y


jobPlaceAction: Float -> Float -> Int -> J.Action -> String
jobPlaceAction sx sy n a = 
    let 
        x = sx + 10 * (modBy 4 n |> toFloat) + if n >= 4 then 10 else 0
        y = sy + 10 * (n // 4 |> toFloat)
    in
        if modBy 4 n == 0  && n > 0 then
             jobCornerArrow (x - 10) y  ++ action x y a 
        else
            action x y a

place : Float -> Float -> J.Place ->  String
place x y p =
        jobPic x y (placePic p)

resPic: J.Resource  -> String
resPic r = 
    case r of 
        J.Gold -> "gold"
        J.Iron -> "iron"
        J.Food -> "food"
        J.Wood -> "wood"
        J.VP -> "vp"
        J.Any -> "any"

placePic:J.Place -> String
placePic p = 
    case p of
        J.Water -> "water"
        J.Mountain -> "mountain"
        J.River -> "river"
        J.Prairie -> "prairie"
        J.Forest -> "forest"
        J.Village -> "village"

jobS: Float -> Float -> String -> String -> String
jobS x y fname s = 
    String.join "\n" 
        [ jobPic x y fname
        , gainText (x+10) (y + 3) "blue" s
        ]

jobN : Float -> Float -> String -> J.JobNum -> String
jobN x y fname n = jobS x y fname (J.jnum n)

jobTextn : Float -> Float -> String ->J.JobNum -> String
jobTextn x y tx n = 
    String.join "\n" 
        [ jobText (x + 5) (y + 4) (tx)
        , jobText (x + 5) (y + 9) (J.jnum n)
        ]

jobText : Float -> Float -> String -> String
jobText x y str = text "Arial" 4 [xy x y,bold,txCenter,flStk "white" "black" 0.4,strokeFirst ] str

idText : Float -> Float -> String -> String -> String
idText x y col tx =
        text "Arial" 6 [xy x y ,flStk col "white" 0.5, strokeFirst,bold,txCenter] (tx )

gainText : Float -> Float -> String -> String -> String
gainText x y col tx =
        text "Arial" 4 [xy x y ,flStk col "white" 0.6, strokeFirst,bold,txRight] (tx )

cardIconText : Float -> Float ->String -> String -> String
cardIconText x y tcol tx  = 
    text "Arial" 7 [xy x y, flStk tcol "white" 0.6,strokeFirst,bold,txCenter] tx

jobCard : Float -> Float -> J.CardType -> String -> String -> J.JobNum -> String
jobCard x y ct tx tcol n =
    let 
        stk = case n of 
            J.This -> narrowStk (cTypeColor ct) "red"
            _ -> narrowStk (cTypeColor ct) "black"
    in 
        String.join "\n" 
            [ g [ rotate 30 (x + 5) (y + 5)]
                [ rect (x+2) y 6 10 [ stk , rxy 1 1 ]        
                , if n == J.This then 
                    cardIconText (x + 5) (y + 8) tcol "!"
                    else ""
                ]
            , cardLetter (x + 1) (y + 9) ct
            , gainText (x + 10) (y+3) tcol (tx ++ J.jnum n)

            ]

cardLetter : Float -> Float -> J.CardType -> String
cardLetter x y ct =
    case ct of
        J.TDanger d -> idText (x+1) y "red" (J.dangerType d)
        J.TStarter -> 
            polygon (starPoints x (y - 4) 5 5 ) [narrowStk "yellow" "black"]
        _ -> ""

jobArrow : Float -> Float -> String 
jobArrow x y =
    polygon (jobArrowPoints x y 7 7) [narrowStk "red" "white" ,prop "class" "arrow"]

jobCornerArrow : Float -> Float -> String
jobCornerArrow x y =
    etag "path" 
    [ prop "d" (String.join " " (jobCornerArrowPath x y 8 8))
    , narrowStk "red" "white" 
    , prop "class" "arrow"
    ]

qStar : Float -> Float -> String -> String -> String
qStar  x y col oline= 
    polygon (starPoints x y 10 10) [narrowStk col oline]

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

resource : Float -> Float ->J.Resource -> String -> String -> J.JobNum -> String
resource x y r tcol sym n =
    String.join "\n" 
        [ jobPic x y (resPic r) 
        , gainText (x + 10) (y + 3) tcol (sym ++ J.jnum n)
        ]
jobCornerArrowPath : Float -> Float -> Float -> Float -> List String
jobCornerArrowPath x y w h =
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
