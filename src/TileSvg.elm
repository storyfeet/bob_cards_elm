module TileSvg exposing(..)
import Land exposing (..)
import PageSvg exposing(..)
import Job exposing (Job)
import JobSvg as JSV

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
        BanditCamp -> "bandit_camp"

        
pLink : LType -> String
pLink = tileLink "../pics/"

tileLink:String -> LType -> String
tileLink root tl =
    root ++ (tileName tl) ++ ".svg" 


front : Tile->String
front t =
    String.join "\n" 
    [ img 0 0 45 45  (pLink t.ltype) [fprop "opacity" 0.5]
    , tileJob t
    ]

tileJob : Tile -> String
tileJob t =
    case t.ltype of
        Village j -> job j
        Water -> ""
        BanditCamp ->  String.join "\n" 
            [ bStar 30 5 t.bandits
            , bStar 5 5 (rotBy 8 (t.bandits + 2 ))
            , bStar 17.5 30 (rotBy 8 (t.bandits + 4 ))
            ]
        _ -> bStar 30 5 t.bandits

rotBy : Int -> Int -> Int
rotBy r n =
    (modBy r (n - 1) ) + 1

bStar : Float -> Float -> Int -> String
bStar x y n = String.join "\n" 
            [ JSV.qStar x y "red" "black"
            , text "Arial" 6.5 [xy (x + 5) (y + 7) ,flStk "white" "black" 0.5, strokeFirst,bold,txCenter] (String.fromInt n)
            ]

    


    
job: Job -> String
job j = 
    let 
        x = ( 45 - (JSV.jobLen j)) * 0.5
        
    in
         JSV.job 41 x 32 j


