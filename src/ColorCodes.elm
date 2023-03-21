module ColorCodes exposing (..)
import Job as J 

cTypeColor : J.CardType -> String
cTypeColor ct =
    case ct of
        J.TAny -> "white" 
        J.TFight -> scarlet
        J.TMove -> blueJean
        J.TGather -> orange
        J.TDanger _ -> darkGray
        J.TTrade -> yellow
        J.TMake -> darkTan
        J.THealth -> emeraldGreen


scarlet : String 
scarlet = "#c72a28"

blueJean : String
blueJean = "#306393"

orange : String
orange = "#ff7100"

darkGray : String
darkGray = "#222222"

yellow :String
yellow = "#dda417"

darkTan : String
darkTan = "#70501f"

emeraldGreen : String
emeraldGreen = "#008622"

