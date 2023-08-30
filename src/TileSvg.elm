module TileSvg exposing(..)
import Land exposing (..)
import PageSvg exposing(..)
import Job exposing (Job)
import JobSvg as JSV
import Config 

type CanMove 
    = BoatFromWater
    | Boat
    | Walk
    | Walk2
    | Climb

miniPic : Float -> Float -> String -> String
miniPic x y fname =
    img x y 5 5 ("../pics/jobs/" ++ fname  ++ ".svg")[]

movRect: Float -> Float -> Float -> String
movRect x y w =
    rect (x - 1.4) y (w * 6 + 2) 5 [flNoStk "white",opacity 0.4]

drawMovement : Float -> Float -> CanMove -> String
drawMovement x y m =
    case m of
        BoatFromWater -> (movRect x y 2 ) ++ (miniPic x y "from_water")  ++ (miniPic (x + 6) y "sail" ) ++ (miniPic (x + 3) y "from_arrow" )
        Boat -> (movRect x y 1) ++ miniPic x y "sail"
        Walk -> (movRect x y 1) ++ miniPic x y "move"
        Walk2 -> (movRect x y 2) ++ (miniPic x y "move") ++ (miniPic (x + 6) y "move" )
        Climb -> (movRect x y 1) ++ miniPic x y "climb"



tileMovement : LType -> List CanMove
tileMovement t =
    case t of
        Water -> [Boat]
        Mountain -> [Walk2,Climb]
        Forest True -> [Boat,Climb,Walk]
        Prairie True -> [Boat,Climb,Walk]
        _ -> [BoatFromWater,Climb,Walk]

movements : Float -> Float -> List CanMove -> String
movements x y l =
    case l of
        [] -> ""
        h::t -> drawMovement x y h ++ movements x (y - 6) t

wet : Bool -> String
wet b = 
    if b then "_wet" else ""



tileName : LType -> String
tileName tl = 
    case tl of
        Water -> "water"
        Forest w -> "forest" ++ wet w
        Prairie w -> "prarie" ++ wet w
        Village _ -> "village" 
        Mountain -> "mountain"
        BanditCamp _ -> "bandit_camp"


tilePath : String
tilePath = "../pics/tiles/"
        
pLink : LType -> String
pLink = tileLink tilePath

tileLink:String -> LType -> String
tileLink root tl =
    root ++ (tileName tl) ++ ".svg" 


front : Tile -> String
front t =
    String.join "\n" 
    [ img 0 0 45 45  (pLink t.ltype) []
--    , rect 0 0 45 45 [flNoStk "white", opacity 0.5]
    , tileJob t
    , tileMovement t.ltype |> movements 2 38
    ]

back : Tile -> String
back t =
    String.join "\n" [
        img -1 -1 47 47 (tilePath ++ "back.svg") []
        , bStar 17.5 17.5 t.backBandits
        , text "Arial" 4 [xy 4 40,flNoStk "white",fprop "opacity" 0.7] Config.version
    ]

tileJob : Tile -> String
tileJob t =
    case t.ltype of
        Village j -> job j
        BanditCamp j -> String.join "\n" 
            [ job j
            , placeBandits 0 4 t.bandits |> String.join "\n" 
            ]
        _ -> placeBandits 0 1 t.bandits |> String.join "\n" 


banditPos : Int -> Int -> (Float, Float)
banditPos n from = 
    case (n , from )of
        (_,1) -> (17.5,17.5)
        (0,_) -> (34,18)
        (1,_) -> (3,12)
        (2,_) -> (12,3)
        (3,_) -> (26,5)
        (v,_) -> (toFloat v , 15)

placeBandits : Int -> Int -> List Int -> List String
placeBandits n from l = 
    case l of 
        [] -> []
        h :: t -> 
            let 
                (x ,y) = banditPos n from
            in 
                (bStar x y h) :: (placeBandits (n + 1) from t)



rotBy : Int -> Int -> Int
rotBy r n =
    (modBy r (n - 1) ) + 1

bStar : Float -> Float -> Int -> String
bStar x y n = String.join "\n" 
            [ JSV.jobPic x y "bandits" 
            , text "Arial" 6.5 [xy (x + 5) (y + 7) ,flStk "white" "red" 0.5, strokeFirst,bold,txCenter] (String.fromInt n)
            ]

    


    
job: Job -> String
job j = 
    let 
        -- x = ( 45 - (JSV.jobLen j)) * 0.5
        x = ( 40 - (JSV.jobLen j))
        
    in
         JSV.job 41 x 32 j


