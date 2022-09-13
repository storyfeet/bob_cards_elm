module CardCanvas exposing (..)

import Canvas as Cv
import Canvas.Settings as Cvs
import Canvas.Settings.Line as CvL
import Canvas.Settings.Text as CvT

import Cards exposing (..)
import Color
import Job exposing (CardType)


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

front: Card -> Cv.Renderable
front c =
    Cv.group [] 
        [ Cv.shapes [tColor c.ctype |> Cvs.fill, Cvs.stroke Color.black] [Cv.rect (0,0) 150 230] 
        , Cv.text titleFont (0,20) c.name
        ]


titleFont: List Cvs.Setting 
titleFont = 
    [ Cvs.fill Color.black
    , Cvs.stroke Color.yellow
    , CvL.lineWidth 0.2
    , CvT.font {size = 15,family = "Arial"}
    ]

