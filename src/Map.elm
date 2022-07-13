module Map exposing (..)
import Grid exposing (..)
import Land exposing (..)
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Line exposing (..)
import Color 
import Dict


startMap : Grid Tile
startMap = 
    emptyGrid 20  
    |> gridPut 10 10 (dry Village 3)
    |> gridPut 10 11 (dry Forest 1 )
    |> gridPut 10 9 (riv Prarie 2)
    |> gridPut 11 10 (dry Forest 5) 
    |> gridPut 9 10 (dry Prarie 9) 





viewMap mp =
    mp.g |> Dict.toList

viewTileAt :Int -> Int -> c -> Shape
viewTileAt sz pos _ =
    let 
        (gx, gy) = gridXY sz pos
    in 
        rect (fxy gx gy)  20 20
        




