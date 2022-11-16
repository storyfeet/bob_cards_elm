module Campaign exposing (..)
import Job exposing (Job)

type alias Campaign =
    { name : String 
    , difficulty : Int
    , dice : Dice
    , mode : Mode
    , board : String
    , setup : String
    , rules : String
    , jobs : List Job
    }

type Mode 
    = Solo
    | Coop
    | Verses



type Dice
    = D8
    | D10
    | D12
    | D20


verses1 : Campaign
verses1 = { name = "Verses 1"
    , difficulty = 1
    , dice = D20
    , mode = Verses
    , board = "Verses Short"
    , setup = ""
    , rules = ""
    , jobs = []
    , scoring = [
        [J.Build ,Reveal 1 2, RemoveBandits 2]
        ]
    }

coop1 : Campaign
coop1 = {verses1 
    | name = "Precious Cargo"
    , mode = Coop
    , board = "Co-op Short"
    , scoring = [Build 2 3, WagonWest 2,RemoveBandits 2 ]
    }


