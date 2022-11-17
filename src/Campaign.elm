module Campaign exposing (..)
import Job as J exposing (on,Job,gain,Resource(..))

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

campaigns : List Campaign
campaigns = [ vs1 
    , coop1
    ]

basicVsScoring : List Job
basicVsScoring =
    [ [on J.OnReveal, gain VP 1, J.Or, on J.OnRevealWest, gain VP 2]
    , [on J.OnBuild, gain VP 2 , J.Or,on J.OnBuildWest, gain VP 3]
    , [on J.OnDefeatBandits , gain VP 2]
    ]

basicWagonScoring : List Job
basicWagonScoring = 
    [ [on J.OnWagonWest, gain VP 2]
    , [on J.OnWagonEast, J.pay VP 2]
    , [on J.OnBuild, gain VP 2]
    , [on J.OnBuildWest, gain VP 3]
    , [on J.OnDefeatBandits , gain VP 2]
    ]


vs1 : Campaign
vs1 = { name = "Verses 1"
    , difficulty = 1
    , dice = D20
    , mode = Verses
    , board = "Verses Short"
    , setup = ""
    , rules = ""
    , jobs = basicVsScoring
    }



coop1 : Campaign
coop1 = {vs1 
    | name = "Precious Cargo"
    , mode = Coop
    , board = "Co-op Short"
    , jobs = basicWagonScoring
    }


