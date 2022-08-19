module Land exposing(..)
import Job exposing (Job,Place)
type alias Tile = 
    { ltype : LType
    , bandits: Int
    }

type LType
    = Water
    | Forest Bool
    | Prarie Bool
    | Village Job
    | Mountain

intToLType: Int -> LType
intToLType n =
    case Basics.modBy 5 n of
        0 -> Water
        1 -> Forest False
        2 -> Forest True
        3 -> Prarie False
        4 -> Prarie True
        _ -> Mountain

isPlace: Place -> LType -> Bool
isPlace p l =
    case (p,l) of
        (Job.River, Forest True) -> True
        (Job.River, Prarie True) -> True
        (Job.Water, Water) -> True
        (Job.Forest, Forest _) -> True
        (Job.Village, Village _) -> True
        (Job.Mountain, Mountain) -> True
        (Job.Prarie , Prarie _) -> True
        _ -> False



intToBool: Int -> Bool
intToBool n =
    case n of
        0 -> False
        _ -> True

tile: Int -> Tile
tile n = 
    let 
        n2 = n // 2
        lt = Basics.modBy 5 n2|> intToLType
        bandits = Basics.modBy 12 n
    in 
        Tile lt bandits
    

tileDeck : Int -> List Tile
tileDeck n =
    case n of
        0 -> [tile 0]
        v -> (tile v) :: (tileDeck (n - 1))

