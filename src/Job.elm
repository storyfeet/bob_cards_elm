module Job exposing (..)


type alias Job =
    List Action


type Place
    = Water
    | Forest
    | Prairie
    | Village
    | Mountain
    | River


type Resource
    = Gold
    | Wood
    | Metal
    | Food
    | VP
    | BanditVP
    | Any


type JobNum
    = N Int
    | X Int
    | D Int
    | XD Int
    | This
    | None


jnum : JobNum -> String
jnum j =
    case j of
        X 1 ->
            "x"
        D 1 ->
            "⬢"
        XD 1 ->
            "x⬢"
        N n ->
            String.fromInt n
        X n ->
            String.fromInt n ++ "x"
        D n ->
            String.fromInt n ++ "⬢"
        XD n ->
            String.fromInt n ++ "x⬢"
        This ->
            ""
        None ->
            ""


type CardType
    = TAny
    | THealth
    | TFight
    | TMove
    | TGather
    | TMake
    | TTrade
    | TDanger DangerType


type DangerType
    = Pain
    | Exhaustion
    | DAny

anyDanger:CardType
anyDanger = TDanger DAny

dangerType : DangerType -> String
dangerType d =
    case d of
        Pain ->
            "P"

        Exhaustion ->
            "E"

        DAny ->
            ""


type Action
    = Move JobNum
    | Or
    | In Place
    | Attack JobNum
    | Defend JobNum
    | Gain Resource JobNum
    | Pay Resource JobNum
    | Draw JobNum
    | Scrap CardType JobNum
    | Take CardType JobNum
    | Discard CardType JobNum
    | BuildRail
    | BuildBridge
    | WaterMove JobNum
    | MountainMove JobNum
    | Reveal JobNum --Num
    | On Event
    | Starter 
    | RideTrain JobNum



type Event 
    = OnWagonWest
    | OnWagonEast
    | OnBarWest
    | OnBuild
    | OnBuildWest
    | OnReveal
    | OnRevealWest
    | OnDefeatBandits
    | OnWagonDamage JobNum
    | OnMoveWest




-- COSTS


pay : Resource -> Int -> Action
pay r n =
    N n |> Pay r


starter : Action
starter =
    Starter 


scrap:  CardType -> Int -> Action
scrap ct n = Scrap ct (N n)

scrapD : Action
scrapD =
    Scrap (TDanger DAny) This


scrapThis : CardType -> Action
scrapThis ct =
    Scrap ct This


payEq : Int -> List Resource -> List Action
payEq n l =
    l |> List.map (\r -> Pay r (N n))


gain : Resource -> Int -> Action
gain r n =
    N n |> Gain r


gather : Resource -> Int -> Action
gather r n =
    Gain r (D n)


attack : Int -> Action
attack n =
    Attack (D n)


defend : Int -> Action
defend n =
    Defend (D n)


draw : Int -> Action
draw n =
    Draw (N n)


discard : Action
discard =
    Discard TAny (N 1)


discardMe : CardType -> Action
discardMe ct =
    Discard ct This


discardD : Action
discardD =
    Discard (TDanger DAny) This

on : Event ->  Action
on e =
    On e


-- JOBS


trade : Resource -> Int -> Resource -> Int -> Job
trade a aN b bN =
    [ Pay a (X aN), Gain b (X bN) ]


riverGather : Resource -> Int -> Job
riverGather =
    gatherAt River


gatherAt : Place -> Resource -> Int -> Job
gatherAt p r n =
    [ In p, Gain r (D n) ]

move : Int -> Action
move n = Move (N n)

foodMove : Int -> Int -> Job
foodMove f d =
    [ Pay Food (N f), Move (N d) ]


muligan : Job
muligan = [ Discard TAny (X 1), Draw (X 1)]

woodMove : Int -> Int -> Job
woodMove w d =
    [ pay Wood w, Move (N d) ]


scrapFor : CardType -> Resource -> Int -> Job
scrapFor ct r n =
    [ scrapThis ct, gain r n ]
