module TileSvg exposing(..)
import Land exposing (..)
import PageSvg exposing(..)
import CardSvg as CS
import Job exposing (Job)

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
        _ -> CS.jobStar 30 5 "red" (Job.N t.bandits)

    
job: Job -> String
job j =
    let 
        x = ( 45 - (CS.jobLen j)) * 0.5
        
    in
         CS.job  x 32 j


