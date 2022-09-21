module Land exposing(..)
import Job exposing (..)
type alias Tile = 
    { ltype : LType
    , bandits: Int
    }

type LType
    = Water
    | Forest Bool
    | Prairie Bool
    | Village Job
    | Mountain

intToLType: Int -> LType
intToLType n =
    case Basics.modBy 6 n of
        0 -> Water
        1 -> Forest False
        2 -> Forest True
        3 -> Prairie False
        4 -> Prairie True
        _ -> Mountain

isPlace: Place -> LType -> Bool
isPlace p l =
    case (p,l) of
        (Job.River, Forest True) -> True
        (Job.River, Prairie True) -> True
        (Job.Water, Water) -> True
        (Job.Forest, Forest _) -> True
        (Job.Village, Village _) -> True
        (Job.Mountain, Mountain) -> True
        (Job.Prairie , Prairie _) -> True
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
    , [Move (N 3)]
    , [Discard TAny (X 1), Gain Iron (X 1)]
    , [Draw (N 2)]
    , [Discard (TDanger DAny) (X 1)]
    , [Discard TAny (X 2), Gain Food (X 3)]
    , [pay Gold 2, Draw (N 4)]
    ]

villageTiles : List Tile
villageTiles = villageJobs |> List.map (\j -> Tile (Village j) 0)

fullDeck : List Tile
fullDeck = villageTiles ++ (basicTiles 40)

