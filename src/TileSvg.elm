module TileSvg exposing(..)
import Land exposing (..)
import PageSvg exposing(..)

wet : Bool -> String
wet b = 
    if b then "_wet" else ""


tileName : LType -> String
tileName tl = 
    case tl of
        Water -> "water"
        Forest w -> "forest" ++ wet w
        Prarie w -> "prarie" ++ wet w
        Village _ -> "village" 
        Mountain -> "mountain"

        
pLink : LType -> String
pLink = tileLink "../pics/"

tileLink:String -> LType -> String
tileLink root tl =
    root ++ (tileName tl) ++ ".svg" 


front : Tile->String
front t =
    img 0 0 25 25  (pLink t.ltype) []

