module CardSvg exposing (..)
import PageSvg exposing (..)
import Cards exposing (..)
import ColorCodes as CC
import Job as J
import JobSvg as JSV
import HasPicList as PicLists
import Config


front :  Card -> String
front card =
    String.join "\n" [ 
        rect 0 0 50 70 [flStk (CC.cTypeColor card.ctype) "white" 0.5,rxy 2 2 ]
        , rect 0 0 50 70 [flNoStk "white", opacity 0.5,rxy 2 2]
        , rect 3 8 44 59 [flNoStk "White" , opacity 0.4, rxy 1 1]
        , cardPic 4 7 card.name
        , costOrType card.cost card.ctype
        , JSV.jobs 41 5 69 card.jobs
        , text "Arial" 5 [
                xy 2 6,flStk "Black" "white" 0.8,bold,strokeFirst
            ] card.name
    ]

back : String
back  = 
    String.join "\n" 
    [ rect -3 -3 56 76 [flNoStk "#f7c9b4"]
    , rect 5 5 40 60 [flStk "none" "black" 1]
    , img 5 15 40 40 "../pics/back_logo.svg" []
    , text "Arial" 4 [xy 6 64,flNoStk "black",opacity 0.6] Config.version

    ]


            
costOrType : List J.Job -> J.CardType -> String
costOrType j ct =
    cardType ct (not (List.isEmpty j)) ++ costList j 38 14
--    case (j,ct) of
--        (_,J.TDanger _) -> cardType ct
--        ([],_) -> cost 2 38 2 [J.Starter] 
--        _ -> cost 2 38 2 [J.Starter] ++ (costList j 38 14) 



costList : List J.Job -> Float -> Float -> String
costList l x y = 
    case l of 
        [] -> ""
        h::t -> 
            let
                len = 10 * List.length h |> toFloat
            in
                String.join "\n" [
                    JSV.jobRect x y 11 (len + 1)
                    , cost y x y h
                    , costList t x (y + len + 3)
                ]


cost : Float -> Float -> Float -> J.Job -> String
cost top x y c = 
    case c of 
        [] -> ""
--        J.Or::t -> cost (top+2) (x - 12) (top + 2 ) t
        h::t -> JSV.action x y h ++ cost top x (y+10 ) t

cardType : J.CardType -> Bool -> String
cardType ct hasJobs = 
    case (ct,hasJobs) of
        (J.TDanger d,_) ->  
            String.join "\n" 
                [ JSV.qStar 38 2 "black" "white"
                , JSV.idText 43 10 "red" "white" (J.dangerType d)
            ]
        (_, True) ->
            String.join "\n" 
                [ JSV.qStar 38 2 "yellow" "black"
                , JSV.idText 43 10 "red" "yellow" "T"
            ]
        (_, False) ->
            String.join "\n" 
                [ JSV.qStar 38 2 "yellow" "black"
                , JSV.idText 43 10 "red" "yellow" "S"
            ]









        

dangerStar : Float -> Float -> String -> String -> J.JobNum -> String
dangerStar x y col tx n =
    String.join "\n"
        [ polygon (JSV.starPoints x y 10 10) [narrowStk col "black" ]
        , JSV.idText (x+ 2.5) ( y+7) "grey" "white" (tx)
        , case n of 
            J.None -> ""
            _ -> JSV.gainText (x + 10) (y + 3 ) "Green" ("+" ++ J.jnum n)
        ]



cardPic: Float -> Float -> String -> String
cardPic x y cname = 
    case  cardPicFile cname of
        Just f -> img x y 27 27 f []
        Nothing -> ""


        


cardPicFile : String -> Maybe String
cardPicFile = Cards.imageFile PicLists.pList ".svg" "../pics/cards/"



