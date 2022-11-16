module CardSvg exposing (..)
import PageSvg exposing (..)
import Cards exposing (..)
import Job as J
import JobSvg as JSV
import HasPicList as PicLists


front :  Card -> String
front card =
    String.join "\n" [ rect 0 0 50 70 [flStk (cTypeColor card.ctype) "white" 0.5, fprop "opacity" 0.5]
    , rect 3 8 44 59 [flNoStk "White" , fprop "opacity" 0.4 ]
    , cardPic 4 7 card.name
    , text "Arial" 5 [xy 2 6,flStk "Black" "white" 0.8,bold,strokeFirst
    ] card.name
    , costOrType card.cost card.ctype
    , JSV.jobs 5 69 card.jobs
    ]

back : String
back  = 
    String.join "\n" 
    [ rect -3 -3 56 76 [flNoStk "#f7c9b4"]
    , rect 5 5 40 60 [flStk "none" "black" 1]
    , img 5 15 40 40 "../pics/back_logo.svg" []

    ]


            
costOrType : J.Job -> J.CardType -> String
costOrType j ct =
    case j of
        [] -> cardType ct
        _ -> cost 2 38 2 j

cost : Float -> Float -> Float -> J.Job -> String
cost top x y c = 
    case c of 
        [] -> ""
        J.Or::t -> cost (top+2) (x - 12) (top + 2 ) t
        h::t -> JSV.action x y h ++ cost top x (y+10 ) t

cardType : J.CardType -> String
cardType ct = 
    case ct of
        J.TDanger d ->  
            String.join "\n" 
                [ JSV.qStar 38 2 "black" "white"
                , JSV.idText 43 10 "red" (J.dangerType d)
            ]
        _ -> JSV.qStar 38 2 (cTypeColor ct) "black"







        

dangerStar : Float -> Float -> String -> String -> J.JobNum -> String
dangerStar x y col tx n =
    String.join "\n"
        [ polygon (JSV.starPoints x y 10 10) [narrowStk col "black" ]
        , JSV.idText (x+ 2.5) ( y+7) "grey" (tx)
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



