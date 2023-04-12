module JobString exposing (..)
import Job exposing (..)

type WriteState
    = WReady
    | WGain
    | WOn



jobStr : Job -> String
jobStr j =
    case j of
        (On e)::t -> "When " ++ eventToString e ++ onStr t
        (Gain _ _)::_ -> "Gain " ++ gainStr j
        (In p)::t -> "If " ++ placeToString p ++ jobContStr t
        a::t -> capFirst (actionStr a) ++ jobContStr t 
        [] -> "."

jobContStr : Job -> String
jobContStr j = 
    case j of
        (On e)::t -> ", when " ++ eventToString e ++ onStr t
        (In p)::t -> ". If " ++ placeToString p ++ jobAlsoIfStr t 
        (Gain _ _)::_ -> ", gain " ++ gainStr j
        a::t -> ", " ++ actionStr a ++ jobContStr t 
        [] -> "."

gainStr : Job -> String
gainStr j =
    case j of
        (Gain r n)::(Gain _ _)::(Gain _ _)::_ -> resStr r n  ++ ", " ++ gainStr (List.drop 1 j)
        (Gain r n)::(Gain _ _)::_ -> resStr r n ++ " and " ++ gainStr (List.drop 1 j)
        (Gain r n)::t -> resStr r n  ++ jobContStr t
        t -> jobContStr t

resStr : Resource -> JobNum -> String
resStr r n = jNumToString n ++ " " ++ resourceToString r

onStr : Job -> String
onStr j  =
    case j of 
        (On e)::t -> " and " ++ eventToString e ++ onStr t
        (In p)::t -> ", if " ++ placeToString p ++ jobContStr t
        _ -> jobContStr j

jobAlsoIfStr : Job -> String
jobAlsoIfStr j = 
    case j of
        (In p)::t -> " and " ++ placeToString p ++ jobAlsoIfStr t
        a::t -> ", also " ++ actionStr a ++ jobContStr t 
        [] -> "."

actionStr : Action -> String 
actionStr a = 
    case a of
        On e -> eventToString e
        In p -> placeToString p
        Gain r n -> "gain " ++ (jNumToString n) ++ " " ++ resourceToString r
        Pay VP n -> "lose " ++ (jNumToString n) ++ " VP"
        Pay r n -> "pay " ++ (jNumToString n) ++  " " ++ resourceToString r
        Or -> "or"
        Discard c n -> "discard " ++ (jNumToString n) ++ " " ++ (cTypeToString c) ++ " cards"
        RideTrain n -> "ride the train up to " ++ (jNumToString n) ++ " tiles"
        Move n -> "move " ++ pluralJ "space" "spaces" n
        Scrap t n -> "scrap " ++ jNumToString n ++ " " ++ cTypeToString t 
        _ -> "-- UNDEFINED actionStr--"


jobToString: Job -> String
jobToString j =
    "* " ++ jobStr j 

{--
actionToString : WriteState -> Action -> (String , WriteState)
actionToString ws a = 
    case (ws,a) of
        (WOn,On e) -> ("and " ++ eventToString e, WOn)
        (_ , On e ) -> ("When " ++ eventToString e, WOn)
        (_ ,In p) -> (placeToString p, WReady)
        (WGain, Gain r n) -> ("and " ++ (jNumToString n) ++  " " ++ resourceToString r, WGain )
        (_ ,Gain r n) -> ("gain " ++ (jNumToString n) ++ " " ++ resourceToString r, WGain)
        (_, Pay VP n) -> ("lose " ++ (jNumToString n) ++ " VP", WReady)
        (_, Pay r n) -> ("pay " ++ (jNumToString n) ++  " " ++ resourceToString r,WReady)

        (_,Or) -> ("or",WReady)
        (_, Move n) -> ("move " ++ (jNumToString n) ++ " spaces",WReady)
        (_, Scrap t n) -> (("scrap " ++ jNumToString n) ++ " " ++ cTypeToString t , WReady) 
        _ -> ("-- UNDEFINED action --",WReady)

--}
placeToString : Place -> String
placeToString p = 
    case p of
        Water -> "in Water"
        Mountain -> "on Mountain"
        River -> "on a tile with a River"
        Prairie -> "on a Prairie"
        Forest -> "in a Forest"
        Village  -> "in a Village"
        WestMost -> "you are doing this the furthest West yet"
        MovingWest -> "you moved West to do this"


cTypeToString : CardType -> String
cTypeToString ct = 
    case ct of
        TAny -> "item"
        TDanger DAny -> "danger"
        _ -> "UNDEFINED CARDS"



eventToString : Event -> String
eventToString e =
    case e of
        OnWagonWest -> "the wagon moves West"
        OnWagonEast -> "the wagon moves East"
        OnBuild -> "you build"
        OnBuildWest -> "you build the furthest West yet"
        OnReveal -> "you reveal a tile"
        OnRevealWest -> "you reveal the most West tile"
        OnDefeatBandits -> "you clear a tile of bandits"
        OnWagonDamage n -> "the wagon takes " ++ jNumToString n ++ " damage"
        OnMoveWest -> "you move west"

resourceToString : Resource -> String
resourceToString r = 
    case r of
        Gold -> "gold"
        Metal -> "metal"
        Food -> "food"
        Wood -> "wood"
        VP -> "VP"
        BanditVP -> "Bandit VP"
        Any -> "of any resource"


jNumToString : JobNum -> String
jNumToString j =
    case j of
        N n -> String.fromInt n
        D n -> String.fromInt n ++ " dice's worth of"
        X 1 -> "x"
        X n -> String.fromInt n ++ "x"
        XD n -> String.fromInt n ++ "x dice's worth of"
        This -> "This"
        None -> "None"

plural: String -> String -> Int -> String
plural s p n =
    if n == 1 then
        s
    else 
        p

pluralJ: String -> String -> JobNum -> String
pluralJ s p n =
    if n == (N 1) then
        "1 " ++ s
    else
        jNumToString n ++ " " ++ p

capFirst: String -> String
capFirst s =
    case s of
        "" -> ""
        _ -> 
            let 
                hd = String.left 1 s
                tl = String.dropLeft 1 s
            in
                String.toUpper hd ++ tl
