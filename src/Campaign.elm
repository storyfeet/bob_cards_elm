module Campaign exposing (..)
import Job as J exposing (on,Job,gain,Resource(..))

type alias Campaign =
    { name : String 
    , difficulty : Int
    , mode : Mode
    , boards : List String
    , setupPic : String
    , setup : List String
    , rules : List String
    , jobs : List Job
    }

type Mode =
    Solo
    | Coop
    | Verses


campaigns : List Campaign
campaigns = [ vs1 
    , onlyWest 
    , coop1
    , coop2
    , thereAndBackAgain
    ]

basicVsScoring : List Job
basicVsScoring =
    [ [on J.OnReveal, gain VP 1, J.Or, on J.OnRevealWest, gain VP 2]
    , [on J.OnBuild, gain VP 2 , J.Or,on J.OnBuildWest, gain VP 3]
    , [on J.OnDefeatBandits , gain VP 2]
    ]

basicWagonScoring : List Job
basicWagonScoring = 
    [ [on J.OnWagonWest, gain VP 2, J.Or, on J.OnWagonEast, J.pay VP 2]
    , [on J.OnBuild, gain VP 2, J.Or ,on J.OnBuildWest, gain VP 3]
    , [on J.OnDefeatBandits , gain VP 2]
    ]


vs1 : Campaign
vs1 = { name = "Standard Verses"
    , difficulty = 1
    , mode = Verses
    , boards = ["A","B"]
    , setup = ["Board = A"]
    , setupPic = "basic_vs"
    , rules = []
    , jobs = basicVsScoring
    }

onlyWest:Campaign
onlyWest = {vs1 
    | name = "Only West"
    , difficulty = 2
    , jobs = [[on J.OnRevealWest , gain VP 3]]
    }


coop1 : Campaign
coop1 = {vs1 
    | name = "Precious Cargo"
    , mode = Coop
    , boards = ["C","D"]
    , setup = ["Board = B"]
    , jobs = basicWagonScoring
    }

coop2 : Campaign
coop2 = {coop1 
    | name = "Speed of the Slowest"
    ,jobs = [
        [on J.OnBuild, gain VP 2 , J.Or,on J.OnBuildWest, gain VP 3]
        , [on J.OnBarWest, gain VP 3]
        , [on J.OnDefeatBandits , gain VP 2]
        ]
    }

thereAndBackAgain : Campaign
thereAndBackAgain = {coop1 
    | name = "There and Back Again"
    , difficulty = 2
    , jobs = [
        [on J.OnRevealWest, gain VP 3]
        , [ on J.OnDefeatBandits, J.Gain Any (J.D 3)]
        ]
    , rules = ["Do not remove any Tiles from the the board", "To win you need:","- To complete the score track","- All players on the starting tile" ]
    }
