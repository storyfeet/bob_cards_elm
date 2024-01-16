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
    | BanditCamp Job
    | Mountain

intToLType: Int -> LType
intToLType n =
    case Basics.modBy 10 n of
        0 -> Water
        1 -> Water
        2 -> Mountain
        3 -> Mountain
        4 -> Forest False
        5 -> Forest False
        6 -> Forest True
        7 -> Prairie False
        8 -> Prairie True
        _ -> Prairie True

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
        (g1, back) = gnext g 12
    in 
        case t of
            BanditCamp _ -> 
                let 
                    (g2 , a)  = gnext g1 12 
                    (g3 , b)  = gnext g2 12 
                    (g4 , c)  = gnext g3 12
                    (g5 , d)  = gnext g4 12
                in
                    (g5,[a + 1 ,b + 1 ,c + 1,d + 1],back + 1)
            Village _ -> (g1,[],back + 1)
            _ -> 
                let 
                    (g2, a) = gnext g1 30
                in
                    if a < 12 then
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
    , [Scrap TAny (X 1),Gain Any (X 1)]
    , [Discard TAny (X 1), Gain Metal (X 1)]
    , [Draw (N 2)]
    , [Discard (TDanger DAny) (X 1)]
    , [Discard TAny (X 2), Gain Food (X 3)]
    , [pay Gold 2, Draw (N 4)]
    ]

campJobs : List Job 
campJobs = 
    [ [Discard (TAny) (X 1),Gain Any (X 3)] 
    , [Scrap (TDanger DAny) (X 1), Gain Gold (X 3)]
    , [Scrap (TDanger DAny) (X 1), Draw (X 2)]
    , [scrap TAny 1, gain Gold 6]
    ]

toTiles : (a -> LType) -> GGen -> List a ->  (GGen,List Tile )
toTiles fTile gen jobs = 
    case jobs of
        [] -> (gen,[])
        h::t ->  
            let 
                lt = (fTile h)
                (g2,fr,bk) = buildBandits gen lt
                (g3,tail) = toTiles fTile g2 t
            in 
                (g3,(Tile lt fr bk) ::tail)




fullDeck : List Tile
fullDeck = 
    let 
        (g2,basics) =(basicTiles (MRand.gn 11) 36) 
        (g3, vTiles) = toTiles (Village) g2 villageJobs
        (_ , bTiles)  = toTiles (BanditCamp) g3 campJobs
    in 
        vTiles ++ bTiles ++ basics 

