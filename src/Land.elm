module Land exposing(..)
import Job exposing (..)
import MRand exposing (gnext,GGen)

type alias Tile = 
    { ltype : LType
    , bandits: List Int
    , backBandits : Int
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

tileGen: GGen -> Int ->  (GGen,Tile)
tileGen g n = 
    let 
        lt = intToLType n
        (g2,f,b) = buildBandits g lt
    in 
        (g2, Tile lt f b)
    
buildBandits : GGen -> LType ->  (GGen,List Int, Int)
buildBandits g t = 
    let 
        (g1, back) = gnext g 8
    in 
        case t of
            BanditCamp -> 
                let 
                    (g2 , a)  = gnext g1 8
                    (g3 , b)  = gnext g2 8
                    (g4 , c)  = gnext g3 8
                in
                    (g4,[a + 1 ,b + 1 ,c + 1],back + 1)
            Village _ -> (g1,[],back + 1)
            _ -> 
                let 
                    (g2, a) = gnext g1 12
                in
                    if a < 8 then
                        (g2,[a + 1],back + 1)
                    else (g2,[],back + 1)

basicTiles : GGen -> Int -> (GGen,List Tile)
basicTiles gen n =
    case n of
        0 -> (gen,[])
        _ -> 
            let
                (g2, tail) = basicTiles gen (n - 1)
                (g3, head) = tileGen g2 n
            in
                (g3,head:: tail)

villageJobs : List Job
villageJobs =
    [ [discard, gain Gold 1]
    , [pay Gold 1, Scrap (TDanger DAny) (X 1)]
    , [Move (N 2)]
    , [Discard TAny (X 1), Gain Metal (X 1)]
    , [Draw (N 2)]
    , [Discard (TDanger DAny) (X 1)]
    , [Discard TAny (X 2), Gain Food (X 3)]
    , [pay Gold 2, Draw (N 4)]
    ]

toVillages : GGen -> List Job -> (GGen,List Tile )
toVillages gen jobs = 
    case jobs of
        [] -> (gen,[])
        h::t ->  
            let 
                (g2,fr,bk) = buildBandits gen (Village h)
                (g3,tail) = toVillages g2 t
            in 
                (g3,(Tile (Village h) fr bk) ::tail)

fullDeck : List Tile
fullDeck = 
    let 
        (g2,basics) =(basicTiles (MRand.gn 11) 40) 
        (_, vTiles) = toVillages g2 villageJobs
    in 
        vTiles ++ basics

