module Job exposing (..)
type alias Job = List Action
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


type JobNum 
    = N Int
    | X Int
    | This
    | None

jnum: JobNum -> String
jnum j =
    case j of
        X 1 -> "?"
        N n -> String.fromInt n
        X n -> String.fromInt n ++ "?"
        This -> "!"
        None -> ""

type CardType 
    = TAny
    | TStarter 
    | TFight
    | TMove
    | TGather
    | TMake
    | TTrade
    | TPlayer
    | TDanger DangerType

type DangerType
    = Lack
    | Pain
    | Exhaustion
    | DAny

dangerType: DangerType -> String
dangerType d = 
    case d of
        Lack -> "L"
        Pain -> "P"
        Exhaustion -> "E"
        DAny -> "*"

type Action
    = Move JobNum
    | Or 
    | In Place
    | Attack JobNum
    | Defend JobNum
    | Gain Resource JobNum
    | Pay Resource JobNum
    | Gather Resource JobNum
    | Draw JobNum
    | Scrap CardType JobNum
    | Take CardType JobNum
    | Discard CardType JobNum
    | BuildRail
    | Starter JobNum
    | Player

-- COSTS

pay : Resource -> Int -> Action
pay r n = 
    N n |> Pay r

starter : Int -> Action
starter n = Starter (N n)



payEq : Int ->  List Resource -> List Action
payEq n l =
    l |> List.map (\r-> Pay r (N n)) 

gain : Resource -> Int -> Action
gain r n =
    N n |> Gain r 

gather : Resource -> Int -> Action
gather r n =
    Gather r (N n)
    

attack : Int -> Action
attack n =
    Attack (N n)

defend : Int -> Action
defend n =
    Defend (N n)

draw : Int -> Action
draw n =
    Draw (N n)

discard : Action
discard = 
    Discard TAny (N 1)

-- JOBS
trade : Resource -> Int -> Resource -> Int -> Job
trade a aN b bN =
    [Pay a (X aN) , Gain b (X bN)]

riverGather : Resource -> Int ->Job
riverGather = gatherAt River

gatherAt : Place -> Resource -> Int -> Job
gatherAt p r n = 
    [In p,Gather r (N n)  ]


foodMove : Int -> Int -> Job
foodMove f d = [Pay Food (N f),Move(N d)]

woodMove : Int -> Int -> Job
woodMove w d = [pay Wood w, Move(N d) ]


scrapFor : Resource -> Int -> Job
scrapFor r n =
    [Scrap TAny This, gain r n]

