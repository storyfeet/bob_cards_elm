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

jnum: JobNum -> String
jnum j =
    case j of
     --   N 1 -> ""
        X 1 -> "X"
        N n -> String.fromInt n
        X n -> String.fromInt n ++ "x"

type Benefit
    = Movement JobNum
    | Attack JobNum
    | Defend JobNum
    | Gain Resource JobNum
    | Gather Resource JobNum
    | Draw JobNum
    | ScrapB JobNum


pay : Resource -> Int -> Cost
pay r n = 
    N n |> Pay r



payL : List (Resource, Int) -> Cost
payL l =
    l |> List.map (\(r,n) -> pay r n ) |> And

payEq : Int ->  List Resource -> Cost
payEq n l =
    l |> List.map (\r-> Pay r (N n)) |> And

gain : Resource -> Int -> Benefit
gain r n =
    N n |> Gain r 

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

