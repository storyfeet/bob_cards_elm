module Map exposing (..)
import Dict exposing (..)
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Line exposing (..)
import Color 
import Message exposing( Msg)
import Html.Attributes exposing (..)


import Html exposing (..)


gridPos : Int -> Int -> Int -> Int
gridPos w x y =
    y * w + x

gridXY :Int -> Int -> (Int , Int)
gridXY w p =
    (Basics.modBy w p, w // p)



type alias Grid t =
    { size : Int
    , g : Dict Int t
    }

gridPut :Grid t-> Int -> Int -> t -> Grid t
gridPut g  x y v = 
    let pos = gridPos g.size x y
    in
    {g | g = Dict.insert pos v g.g}

gridGet : Grid t -> Int -> Int -> Maybe t 
gridGet g x y = 
    let pos = gridPos g.size x y
    in 
    Dict.get pos g.g


type alias Tile = 
    { river : Bool
     ,ltype : LType
    }


type LType
    = Water
    | Forest
    | Prarie
    | Village
    | Mountain

view: Html Msg
view = 
    Canvas.toHtml (300,400)
    [style "width" "300px", style "height" "400px", style "border" "2px solid black", style "position" "absolute"]
    [shapes [fill Color.black ] [hexPath 50 50 200 100] ]



xy x y = 
    (x,y)
hexPath x y w h =
    let 
        xmid = x + w/2
        y1 = y + (h/4)
        y2 = y + ((3*h)/4)
    in
    [ xy (x+w) y1
    , xy (x+w) y2
    , xy xmid (y + h)
    , xy x y2
    , xy x y1
    , xy xmid y
    ] 
    |> List.map lineTo
    |>path (xy xmid y )  

    

