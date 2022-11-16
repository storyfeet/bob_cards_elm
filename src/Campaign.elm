module Campaign exposing (..)
import Job exposing (Job)

type alias Campaign =
    { name : String 
    , difficulty : Int
    , mode : Mode
    , board : String
    , setup : Maybe String
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
    | RemoveBandits Int


