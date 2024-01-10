module MissionSetup exposing (..)

type Setup =
    Wagon Int
    | Score Mode
    | Bandits (List Int)
    | Grid Int
    | OneMeeple
    | TwoMeeples
    | ThreeMeeples
    | DayForward
    | Scrap String


type Mode =
    Solo 
    | Coop
    | Versus

setupStr : Setup -> String
setupStr s =
    case s of 
        Wagon 0 -> "Add a Wagon to the same tile as the Meeples"
        Wagon n -> "Add a Wagon " ++ String.fromInt n ++ "tiles West of the Meeples"
        Score Solo -> "Add a Meeple to the '0' score track"
        Score Coop -> "Add a Meeple of any colour to the '0' on the score track"
        Score Versus -> "Add a Meeple for each player to the '0' on the score track"
        Bandits _ -> "Add Bandits ahead of the meeples (TODO)"
        Grid n -> "Layout " ++ String.fromInt (n*3) ++ " tiles face up in a " ++ String.fromInt n ++ "x3 Grid.\nPlace face down tiles around them to the North, South, and West (No Diagonal)"
        OneMeeple -> "Add a Meeple to the Central Eastmost Tile"
        TwoMeeples -> "Add 2 Meeples to the Central Eastmost Tile"
        ThreeMeeples -> "Add a Meeple for each player the the Central Eastmost Tile"
        DayForward -> "Move the day tracker forward 1 space for every player above 2" 
        Scrap sc -> "Each player may scrap the " ++ sc ++ " from their deck"


modeStr : Mode -> String
modeStr m =
    case m of
        Solo -> "Solo"
        Coop -> "Cooperative"
        Versus -> "Versus"
