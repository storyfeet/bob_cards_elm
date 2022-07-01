module Land exposing(..)
type alias Tile = 
    { ltype : LType
    , river : Bool
    , bandits: Int
    }

type LType
    = Water
    | Forest
    | Prarie
    | Village
    | Mountain

intToLType: Int -> LType
intToLType n =
    case Basics.modBy 5 n of
        0 -> Water
        1 -> Forest
        2 -> Prarie
        3 -> Village
        _ -> Mountain
        


riv : LType -> Int -> Tile
riv l n =
    Tile l True n
dry: LType -> Int -> Tile
dry l n =
    Tile l False n

intToBool: Int -> Bool
intToBool n =
    case n of
        0 -> False
        _ -> True

tile: Int -> Tile
tile n = 
    let 
        isRiv = Basics.modBy 2 n |> intToBool
        n2 = n // 2
        lt = Basics.modBy 5 n2|> intToLType
        bandits = Basics.modBy 12 n
    in 
        Tile lt isRiv bandits
    

tileDeck : Int -> List Tile
tileDeck n =
    case n of
        0 -> [tile 0]
        v -> (tile v) :: (tileDeck (n - 1))

