module CardSvg exposing (..)
import PageSvg exposing (..)
import Cards exposing (..)
import Job exposing (..)


front :  Card -> String
front card =
    String.join "\n" [ rect 0 0 50 70 [flStk (cTypeColor card.ctype) "white" 0.5, fprop "opacity" 0.5]
    , rect 5 5 40 60 [flNoStk "White" , fprop "opacity" 0.4 ]
    , cardPic 4 6 card.name
    , text "Arial" 5 [xy 20 10,narrowStk "Black" "yellow" ,txCenter] card.name
    , costOrType card.cost card.ctype
    , jobs 65 card.jobs
    ]

jobs : Float -> List Job -> String
jobs y l =
    case l of 
        [] -> ""
        h::t -> job 5 (y - jobHeight h) h ++ jobs (y - jobHeight h) t 


job : Float -> Float -> Job -> String
job x y jb = 
    List.indexedMap (jobPlaceAction x y) jb
    |> String.join "\n"
    

jobPlaceAction: Float -> Float -> Int -> Action -> String
jobPlaceAction sx sy n a = 
    let 
        x = sx + 10 * (modBy 4 n |> toFloat) + if n >= 4 then 10 else 0
        y = sy + 10 * (n // 4 |> toFloat)
    in
        if modBy 4 n == 0  && n > 0 then
             jobCornerArrow (x - 10) y  ++ action x y a 
        else
            action x y a

jobHeight : Job -> Float
jobHeight j = 
    jobLen j 
    |> floor
    |> \n -> (n // 41 ) + 1
    |> \a -> a * 12
    |> toFloat


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
        Starter n -> jobStar x y "yellow"  n
        Move n -> jobN x y "move" n
        Attack n -> jobN x y "attack" n
        Defend n -> jobN x y "defend" n
        WaterMove -> jobPic x y "sail" 
        MountainMove -> jobPic x y "climb"
        Reveal n -> jobN x y "reveal" n
        Pay r n -> resource x y r "Red" "-" n 
        Gain r n -> resource x y r "Green" "+" n 
        BuildRail -> jobPic x y "build_rail"

            
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
        TPlayer n -> jobStar 38 2 "blue" (N n)
        _ -> qStar 38 2 (cTypeColor ct) "black"



resource : Float -> Float ->Resource -> String -> String -> JobNum -> String
resource x y r tcol sym n =
    String.join "\n" 
        [ jobPic x y (resPic r) 
        , gainText (x + 10) (y + 3) tcol (sym ++ jnum n)
        --, jobText (x + 5) (y + 9) (resourceShortName r)
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
        , gainText (x + 10) (y+3) tcol (tx ++ jnum n)

        ]

cardLetter : Float -> Float -> CardType -> String
cardLetter x y ct =
    case ct of
        TDanger d -> idText x y "black" (dangerType d)
        TStarter -> 
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
            _ -> gainText (x + 10) (y + 3 ) "Green" ("+" ++ jnum n)
        ]


place : Float -> Float -> Place ->  String
place x y p =
        jobPic x y (placePic p)


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



jobTextn : Float -> Float -> String ->JobNum -> String
jobTextn x y tx n = 
    String.join "\n" 
        [ jobText (x + 5) (y + 4) (tx)
        , jobText (x + 5) (y + 9) (jnum n)
        ]

jobText : Float -> Float -> String -> String
jobText x y str = text "Arial" 4 [xy x y,bold,txCenter,flStk "white" "black" 0.4,strokeFirst ] str

idText : Float -> Float -> String -> String -> String
idText x y col tx =
        text "Arial" 6 [xy x y ,flStk col "white" 0.5, strokeFirst,bold,txCenter] (tx )

gainText : Float -> Float -> String -> String -> String
gainText x y col tx =
        text "Arial" 4.5 [xy x y ,flStk col "white" 0.6, strokeFirst,bold,txRight] (tx )


cardPic: Float -> Float -> String -> String
cardPic x y cname = 
    case  cardPicFile cname of
        Just f -> img x y 35 35 f []
        Nothing -> ""


resPic: Resource  -> String
resPic r = 
    case r of 
        Gold -> "gold"
        Iron -> "iron"
        Food -> "food"
        Wood -> "wood"
        Any -> "any"

placePic:Place -> String
placePic p = 
    case p of
        Water -> "water"
        Mountain -> "mountain"
        River -> "river"
        Prairie -> "prairie"
        Forest -> "forest"
        Village -> "village"
        
jobPic: Float -> Float -> String -> String
jobPic x y fname = 
    img x y 10 10 ("../pics/jobs/" ++ fname  ++ ".svg")[]

jobN: Float -> Float -> String -> JobNum -> String
jobN x y fname n = 
    String.join "\n" 
        [ jobPic x y fname
        , gainText (x+10) (y + 3) "blue" (jnum n)
        ]

cardPicFile : String -> Maybe String
cardPicFile = Cards.imageFile "../pics/cards/"

