module TileSvg exposing(..)
import Land exposing (..)
import PageSvg exposing(..)
import Job exposing (Job)
import JobSvg as JSV
import Config 

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
        (_,1) -> (30,3)
        (0,_) -> (32,15)
        (1,_) -> (3,15)
        (2,_) -> (10,3)
        (3,_) -> (25,3)
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
        x = ( 45 - (JSV.jobLen j)) * 0.5
        
    in
         JSV.job 41 x 32 j


