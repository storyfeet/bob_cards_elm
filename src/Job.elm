module Job exposing (..)
type alias Job =
    { req : Cost
    , for : List Benefit
    }
type Place 
    = Water
    | Forest
    | Prarie
    | Village
    | Mountain
    | River

type Resource  
    = Gold
    | Wood
    | Iron
    | Food
    | Any

type Cost
    = In Place Cost
    | Or (List Cost)
    | And (List Cost)
    | Discard JobNum
    | Pay Resource JobNum
    | ScrapC
    | Starter JobNum
    | Free

type JobNum 
    = N Int
    | X Int
    | This

jnum: JobNum -> String
jnum j =
    case j of
     --   N 1 -> ""
        X 1 -> "?"
        N n -> String.fromInt n
        X n -> String.fromInt n ++ "?"
        This -> "!"

type Benefit
    = Movement JobNum
    | Attack JobNum
    | Defend JobNum
    | Gain Resource JobNum
    | Gather Resource JobNum
    | Draw JobNum
    | ScrapB JobNum
    | ScrapDanger JobNum


-- COSTS

pay : Resource -> Int -> Cost
pay r n = 
    N n |> Pay r

starter : Int -> Cost
starter n = Starter (N n)


payL : List (Resource, Int) -> Cost
payL l =
    l |> List.map (\(r,n) -> pay r n ) |> And

payEq : Int ->  List Resource -> Cost
payEq n l =
    l |> List.map (\r-> Pay r (N n)) |> And

gain : Resource -> Int -> Benefit
gain r n =
    N n |> Gain r 

gather : Resource -> Int -> Benefit
gather r n =
    Gather r (N n)
    

attack : Int -> Benefit
attack n =
    Attack (N n)

defend : Int -> Benefit
defend n =
    Defend (N n)

draw : Int -> Benefit
draw n =
    Draw (N n)

discard : Int -> Cost
discard n = 
    Discard (N n)

-- JOBS
trade : Resource -> Int -> Resource -> Int -> Job
trade a aN b bN =
    Job (Pay a (X aN) ) [Gain b (X bN)]

riverGather : Resource -> Int ->Job
riverGather = gatherAt River

gatherAt : Place -> Resource -> Int -> Job
gatherAt p r n = 
    Job (In p Free ) [Gather r (N n)  ]





foodMove : Int -> Int -> Job
foodMove f d = Job (Pay Food (N f)) [Movement (N d)]

woodMove : Int -> Int -> Job
woodMove w d = Job (pay Wood w) [Movement (N d) ]


scrapFor : Resource -> Int -> Job
scrapFor r n =
    Job ScrapC [gain r n]


freebie : Benefit -> Job 
freebie b = Job Free [b]
freeAttack : Int -> Job
freeAttack a = Job Free [attack a]
freeDefend : Int -> Job
freeDefend d = Job Free [defend d]

