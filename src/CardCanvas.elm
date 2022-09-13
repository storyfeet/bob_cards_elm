module CardCanvas exposing (..)

import Canvas as Cv
import Canvas.Settings as Cvs

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
    Cv.shapes [tColor c.ctype |> Cvs.fill] 
        [ Cv.rect (0,0) 50 70
        ]


