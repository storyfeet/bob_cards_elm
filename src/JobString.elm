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
        a::t -> actionStr a ++ " " ++ jobContStr t 
        _ -> ""

jobContStr : Job -> String
jobContStr j = 
    case j of
        (On e)::t -> "when " ++ eventToString e ++ " " ++ onStr t
        a::t -> actionStr a ++ " " ++ jobContStr t 
        _ -> ""

onStr : Job -> String
onStr j  =
    case j of 
        (On e)::t -> " and " ++ eventToString e ++ onStr t
        _ -> ", " ++ jobContStr j



actionStr : Action -> String 
actionStr a = 
    case a of
        On e -> eventToString e
        In p -> placeToString p
        Gain r n -> "gain " ++ (jNumToString n) ++ " " ++ resourceToString r
        Pay VP n -> "lose " ++ (jNumToString n) ++ " VP"
        Pay r n -> "pay " ++ (jNumToString n) ++  " " ++ resourceToString r
        Or -> "or"
        _ -> "-- UNDEFINED --"


jobToString: Job -> String
jobToString j =
    jobStr j
    --List.foldl (makeAction) ("" ,WReady) j |> (\(s,_)->s)

makeAction :Action -> (String, WriteState) -> (String,WriteState)
makeAction a (s, ws) =
    let 
        (s2 , ws2) = actionToString ws a
    in
        (s ++ ", " ++ s2, ws2)

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
        _ -> ("-- UNDEFINED --",WReady)

placeToString : Place -> String
placeToString p = 
    case p of
        Water -> "In Water"
        Mountain -> "On Mountain"
        River -> "On a tile with a River"
        Prairie -> "On a Prairie"
        Forest -> "In a Forest"
        Village  -> "In a Village"



eventToString : Event -> String
eventToString e =
    case e of
        OnWagonWest -> "the Wagon moves West"
        OnWagonEast -> "the Wagon moves East"
        OnBarWest -> "the Travel Bar moves West"
        OnBuild -> "you build"
        OnBuildWest -> "you build the furthest West yet"
        OnReveal -> "you reveal a tile"
        OnRevealWest -> "you reveal the most West tile"
        OnDefeatBandits -> "you clear a tile of Bandits"
        OnWagonDamage n -> "the wagon takes " ++ jNumToString n ++ " damage"
        OnMoveWest -> "you move west"

resourceToString : Resource -> String
resourceToString r = 
    case r of
        Gold -> "gold"
        Iron -> "iron"
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

