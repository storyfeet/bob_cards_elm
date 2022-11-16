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
        _ -> String.join "\n" 
            [ JSV.qStar 30 5 "red" "black"
            , text "Arial" 6.5 [xy 35 12 ,flStk "white" "black" 0.5, strokeFirst,bold,txCenter] (String.fromInt t.bandits)
            ]


    
job: Job -> String
job j =
    let 
        x = ( 45 - (JSV.jobLen j)) * 0.5
        
    in
         JSV.job  x 32 j


