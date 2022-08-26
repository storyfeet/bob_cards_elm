module Land exposing(..)
import Job exposing (..)
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
    case Basics.modBy 6 n of
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
        lt = Basics.modBy 6 n|> intToLType
        bandits = Basics.modBy 12 (n * 17)
    in 
        Tile lt bandits
    

basicTiles : Int -> List Tile
basicTiles n =
    case n of
        0 -> [tile 0]
        v -> (tile v) :: (basicTiles (n - 1))

villageJobs : List Job
villageJobs =
    [ [discard, gain Gold 1]
    , [pay Gold 1, Scrap (TDanger DAny) (X 1)]

    ]

villageTiles : List Tile
villageTiles = villageJobs |> List.map (\j -> Tile (Village j) 0)

fullDeck : List Tile
fullDeck = villageTiles ++ (basicTiles 30)

