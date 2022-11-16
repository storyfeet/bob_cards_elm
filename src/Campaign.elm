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
    , scoring : List Score
    }

type Mode 
    = Solo
    | Coop
    | Verses


type Score 
    = Build Int Int
    | Reveal Int Int
    | WagonWest Int
    | WagonEast Int
    | BarWest Int
    | RemoveBandits Int

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
    , scoring = [Build 2 3,Reveal 1 2, RemoveBandits 2]
    }

coop1 : Campaign
coop1 = {verses1 
    | name = "Precious Cargo"
    , mode = Coop
    , board = "Co-op Short"
    , scoring = [Build 2 3, WagonWest 2,RemoveBandits 2 ]
    }


