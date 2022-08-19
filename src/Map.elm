module Map exposing (..)
import Grid exposing (..)
import Land exposing (..)
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Line exposing (..)
import Dict
import Job as J


startMap : Grid Tile
startMap = 
    emptyGrid 20  
    |> gridPut 10 10 (Tile (Village (J.trade J.Gold 1 J.Food 4 ))  3)
    |> gridPut 10 11 (Tile (Forest True) 1 )
    |> gridPut 10 9 (Tile (Prarie True) 2)
    |> gridPut 11 10 (Tile (Forest False) 5 ) 
    |> gridPut 9 10 (Tile (Prarie False) 9) 





view mp =
    mp.g |> Dict.toList

viewTileAt :Int -> Int -> c -> Shape
viewTileAt sz pos _ =
    let 
        (gx, gy) = gridXY sz pos
    in 
        rect (fxy gx gy)  20 20
        




