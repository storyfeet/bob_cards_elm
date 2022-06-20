module Map exposing (..)
import Dict exposing (..)
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Color 
import Message exposing( Msg)
import Html.Attributes exposing (..)

import Html exposing (..)


gridPos w x y =
    y * w + x

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
    [shapes [fill Color.black ] [rect (50,50) 200 100] ]

