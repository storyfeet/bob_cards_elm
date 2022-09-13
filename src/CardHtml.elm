module CardHtml exposing (..)

nothing:String
nothing =""
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

