module CardCanvas exposing (..)

import Canvas as Cv
import Canvas.Settings as Cvs
import Canvas.Settings.Advanced as CvSA
import Canvas.Settings.Line as CvL
import Canvas.Settings.Text as CvT
import Canvas.Texture as CTex

import Cards exposing (..)
import Color
import Job exposing (CardType)
import Dict exposing (Dict)


tColor : CardType -> Color.Color
tColor ct = 
    case ct of
        Job.TAny -> Color.white
        Job.TStarter -> Color.yellow
        Job.TFight -> Color.red
        Job.TMove -> Color.darkBlue
        Job.TGather -> Color.darkPurple
        Job.TPlayer _ -> Color.blue
        Job.TDanger _ -> Color.black
        Job.TTrade -> Color.lightPurple
        Job.TMake -> Color.orange
        Job.THealth -> Color.green

lColor : CardType -> Color.Color
lColor ct =
    tColor ct |> lighter

lighter : Color.Color -> Color.Color
lighter c = 
    let 
        hsla = Color.toHsla c
    in 
        Color.fromHsla { hsla | lightness = hsla.lightness * 1.4}

front: (Dict String CTex.Texture)-> Card -> Cv.Renderable
front txset c =
    Cv.group [] 
        [ Cv.shapes [tColor c.ctype |> Cvs.fill, Cvs.stroke Color.black] [Cv.rect (0,0) 150 230] 
        , Cv.shapes [lColor c.ctype |> Cvs.fill] [Cv.rect (10,10) 130 210]
        

        , cardPic txset 20 20 (String.toLower c.name)
        , Cv.text titleFont (0,20) c.name
        ]

cardPic : Dict String CTex.Texture -> Float -> Float -> String -> Cv.Renderable
cardPic txset x y cname =
    case Dict.get cname txset of
        Just t -> Cv.texture [CvSA.transform [CvSA.scale 0.5 0.5] ] (x,y) t
        Nothing -> Cv.shapes [] [Cv.rect (x,y) 20 20]




    


titleFont: List Cvs.Setting 
titleFont = 
    [ Cvs.fill Color.black
    , Cvs.stroke Color.yellow
    , CvL.lineWidth 0.2
    , CvT.font {size = 15,family = "Arial"}
    ]


