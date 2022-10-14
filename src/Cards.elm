module Cards exposing (..)
import Html exposing(..)
import Html.Attributes exposing(..)
import Css exposing (..)
import Job exposing (..)
import HasPicList

type alias Card =
    { name : String
    , ctype : CardType
    , cost : Job
    , jobs : List Job
    }


numItems : String -> JobNum -> List (Html m)
numItems s n =
    [ text s
    , br [] []
    , jnum n |> text 
    ]
viewDiscard : JobNum -> Html m
viewDiscard n = 
    div (cardOuterStyle "red"|> itemStyle) 
    [ div (cardInnerStyle  25 35) []  ,text ("-"++ jnum n)]

viewDraw : JobNum -> Html m
viewDraw n = 
    div (cardOuterStyle "Green"|> itemStyle) 
    [ div (cardInnerStyle  25 35) []  ,text ("+"++ jnum n)]

resourceShortName : Resource -> String
resourceShortName r = 
    case r of
        Gold -> "Gld"
        Wood -> "Wd"
        Iron -> "Ir"
        Food -> "Fd"
        Any -> "Any"

placeShortName: Place -> String  
placeShortName pl =
    case pl of
        River -> "Rvr"
        Forest -> "Frt"
        Mountain -> "Mtn"
        Prairie -> "Pry"
        Water -> "Wtr"
        Village -> "Vlg"


cTypeColor : CardType -> String
cTypeColor ct =
    case ct of
        TAny -> "white"
        TStarter -> "yellow"
        TFight -> "red"
        TMove -> "cyan"
        TGather -> "fuchsia"
        TPlayer _ -> "blue"
        TDanger _ -> "black"
        TTrade -> "pink"
        TMake -> "orange"
        THealth -> "Green"

         

placeColor: Place -> String
placeColor pl = 
    case pl of
        River -> "Cyan"
        Forest -> "Green"
        Mountain -> "Grey"
        Prairie -> "LightGreen"
        Water -> "Blue"
        Village -> "Yellow"
        
resourceColor: Resource ->String
resourceColor r = 
    case r of 
        Food -> "green"
        Iron -> "Grey"
        Wood -> "Brown"
        Gold -> "Gold"
        Any -> "White"



viewPlace : Place -> Html m
viewPlace plc = 
    div (hexStyle "black" 35 |> itemStyle)[
        div (hexStyle (placeColor plc ) 31) [
            text (placeShortName plc)]
        ]

viewEllipse:String -> List( Html m)  -> Html m
viewEllipse col inner =
    div (circleStyle  "black" 35 |> itemStyle) [
        div (circleStyle col 31) 
            inner
        ]

viewRect: String -> List (Html m) -> Html m
viewRect col inner = 
    div (squareStyle col 35 |> itemStyle ) inner


imageFile: String -> String -> Maybe String
imageFile root cname = 
    let 
        lcase = String.toLower cname
    in
    if List.member lcase HasPicList.pList then
        Just (root ++ lcase ++ ".svg")
    else 
        Nothing

