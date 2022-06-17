module Map exposing (..)
import Dict exposing (..)

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



