module Land exposing(..)
import Job exposing (..)
import MRand
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
    | BanditCamp

intToLType: Int -> LType
intToLType n =
    case Basics.modBy 11 n of
        0 -> Water
        1 -> Water
        2 -> Mountain
        3 -> Mountain
        4 -> Forest False
        5 -> Forest False
        6 -> Forest True
        7 -> Prairie False
        8 -> Prairie True
        9 -> Prairie True
        _ -> BanditCamp

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

tile: Int -> Int -> Tile
tile n b= 
    let 
        lt = intToLType n
        bandits = b
    in 
        Tile lt bandits
    



basicTiles : MRand.GGen -> Int -> List Tile
basicTiles gen n =
    let 
        (g2 , b) = MRand.gnext gen 10
    in 
        case n of
            0 -> [tile 0 b ]
            v -> (tile v b) :: (basicTiles g2 (n - 1))

villageJobs : List Job
villageJobs =
    [ [discard, gain Gold 1]
    , [pay Gold 1, Scrap (TDanger DAny) (X 1)]
    , [Move (N 2)]
    , [Discard TAny (X 1), Gain Iron (X 1)]
    , [Draw (N 2)]
    , [Discard (TDanger DAny) (X 1)]
    , [Discard TAny (X 2), Gain Food (X 3)]
    , [pay Gold 2, Draw (N 4)]
    ]

villageTiles : List Tile
villageTiles = villageJobs |> List.map (\j -> Tile (Village j) 0)

fullDeck : List Tile
fullDeck = villageTiles ++ (basicTiles MRand.gzero 39)

