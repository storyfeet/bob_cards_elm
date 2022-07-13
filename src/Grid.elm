module Grid exposing (..)
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
    (Basics.modBy w p, p // w)




type alias Grid t =
    { size : Int
    , g : Dict Int t
    }


emptyGrid n = 
    { size = n
    , g = Dict.empty
    }



gridPut :Int -> Int -> t -> Grid t-> Grid t
gridPut x y v g = 
    let pos = gridPos g.size x y
    in
    {g | g = Dict.insert pos v g.g}

gridGet : Grid t -> Int -> Int -> Maybe t 
gridGet g x y = 
    let pos = gridPos g.size x y
    in 
    Dict.get pos g.g


view: Html Msg
view = 
    Canvas.toHtml (300,400)
    [style "width" "300px", style "height" "400px", style "border" "2px solid black", style "position" "absolute"]
    [shapes [fill Color.black ] [hexPath 50 50 200 100] ]



xy x y = 
    (x,y)

fxy: Int -> Int -> (Float,Float)
fxy x y = 
    (toFloat x , toFloat y)



mapXYList : (Int -> Int -> t -> v) -> Grid t -> List v
mapXYList f g= 
    mapList (\k v -> let (gx ,gy) = gridXY g.size k in f gx gy v ) g
mapList: (Int -> t -> v) -> Grid t -> List v
mapList f gr =
    Dict.foldl (\k v l -> (f k v)::l   ) [] gr.g

hexPath : Float -> Float -> Float -> Float -> Shape
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


 
