module Cards exposing (..)
import Html exposing(..)
import Html.Attributes exposing(..)
import Css exposing (..)
import Job exposing (..)

type alias Card =
    { name : String
    , ctype : CardType
    , cost : List Action
    , jobs : List Job
    }




{--
view : Card -> Html m
view crd = div (cardStyle (cTypeColor crd.ctype))
    [ text crd.name
    , div [style "width" "30",style "position" "absolute", style "right" "0", style "top" "0"] [viewCost crd.cost]
    , crd.jobs |> List.map viewJob |> div [style "position" "absolute" ,style "bottom" "0"] 
    ]



viewJob :Job -> Html m
viewJob jb =
    div [style "clear" "both"] 
    ([ viewCost jb.req 
    , div (itemStyle []) [text "=>"]]++
     (List.map viewBenefit jb.for))
     

--}

{--viewActin : Cost -> Html m
viewCost cst = 
   case cst of 
    In plac ch -> div [] [viewPlace plac, viewCost ch]
    Or l -> l |> List.map viewCost  |> div [classList[( "or_cost",True )]]
    And l -> l |> List.map viewCost  |> div [classList [("and_cost",True)]]
    Discard n -> viewDiscard n
    Pay r n -> viewRect (resourceColor r) (numItems (resourceShortName r) n )
    ScrapC -> viewEllipse "pink" [text "Scrp"]
    Starter n -> viewEllipse "white" [text ("S" ++ jnum n)]
    Player -> viewEllipse "blue" []
    _ -> div [] [] 


viewBenefit: Benefit -> Html m
viewBenefit bn =
    case bn of
        Movement n -> viewEllipse "lightblue" (numItems "Mv" n)
        Attack n -> viewEllipse "red" (numItems "Atk" n)
        Defend n -> viewEllipse "Grey" (numItems  "Dfd" n)
        Gain r n -> viewRect (resourceColor r) (numItems (resourceShortName r) n)
        Gather r n -> viewEllipse (resourceColor r) (numItems (resourceShortName r)  n)
        Draw n -> viewDraw n
        ScrapB n-> viewEllipse "pink" (numItems "Scp" n)
        ScrapDanger n-> viewEllipse "grey" (numItems "Sc d" n)
        GainStarter _ -> viewEllipse "pink" []
        _ -> viewEllipse "Blue" [] -- TODO

--}


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
        Prarie -> "Pry"
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
        Prarie -> "LightGreen"
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



