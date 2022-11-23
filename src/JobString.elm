module JobString exposing (..)
import Job exposing (..)

jobToString: Job -> String
jobToString j =
    List.map (actionToString) j |> String.join ", "

actionToString : Action -> String
actionToString a = 
    case a of
        On e -> eventToString e
        In p -> placeToString p
        Gain r n -> "Gain " ++ (jNumToString n) ++  " " ++ resourceToString r
        Or -> "or"
        _ -> ""

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
        OnWagonWest -> "When the Wagon moves West"
        OnWagonEast -> "When the Wagon moves East"
        OnBarWest -> "When the Travel Bar moves West"
        OnBuild -> "When you build"
        OnBuildWest -> "When you build the most West"
        OnReveal -> "When you reveal a tile"
        OnRevealWest -> "When you reveal the most West tile"
        OnDefeatBandits -> "When you clear a tile of Bandits"

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
        X n -> String.fromInt n ++ "x"
        XD n -> String.fromInt n ++ "x dice's worth of"
        This -> "This"
        None -> "None"

