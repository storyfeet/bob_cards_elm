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

modeStr : Mode -> String
modeStr m =
    case m of
        Solo -> "Solo"
        Coop -> "Co-op"
        Verses -> "VS"


campaigns : List Campaign
campaigns = [ vs1 
    , onlyWest 
    , coop1
    , speedOfTheSlowest
    , escortMission
    , thereAndBackAgain
    , areWeTheBaddies
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
vs1 = { name = "The Race"
    , difficulty = 1
    , mode = Verses
    , boards = ["A","B"]
    , setup = ["Follow the standard game setup"]
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
    , setupPic = "wagon"
    , boards = ["C","D"]
    , setup = ["- Add a Wagon token to the central start tile"
              ,  "- Use a single a neutral token" ]
    , rules = ["To move the Wagon a player must:","- Be on the same square as the wagon", "- Use their own movement actions to move it"]
    , jobs = basicWagonScoring
    }

speedOfTheSlowest : Campaign
speedOfTheSlowest = {coop1 
    | name = "Speed of the Slowest"
    , setupPic = "bar"
    , rules = ["The bar moves west when all players are at least 1 tile west of it"]
    , setup = ["Add the Travel Bar East of the map tiles facing west"]
    ,jobs = [
        [on J.OnBuild, gain VP 2 , J.Or,on J.OnBuildWest, gain VP 3]
        , [on J.OnBarWest, gain VP 3]
        , [on J.OnDefeatBandits , gain VP 2]
        ]
    }

escortMission : Campaign
escortMission = { speedOfTheSlowest
    | name = "Escort Mission"
    , difficulty = 3
    , setup = [ "Add the Travel Bar East of the map tiles facing West"
            , "1 player plays a Character with Difficulty 3"]
    ,jobs = [
        [on J.OnBuild, gain VP 1 ]
        , [on J.OnBarWest, gain VP 3]
        , [on J.OnDefeatBandits , gain VP 1]
        ]
    }

thereAndBackAgain : Campaign
thereAndBackAgain = {coop1 
    | name = "There and Back Again"
    , difficulty = 2
    , setupPic = "coop_basic"
    , setup = ["Use a single neutral score token"]
    , jobs = [
        [on J.OnRevealWest, gain VP 3]
        , [ on J.OnDefeatBandits, J.Gain Any (J.D 3)]
        ]
    , rules = ["Do not remove any Tiles from the the board", "To win you need:","- To complete the score track","- All players on the starting tile" ]
    }

areWeTheBaddies : Campaign
areWeTheBaddies = { coop1
    | name = "Are We the Baddies"
    , setupPic = "coop_basic"
    , setup = ["Use a single nuetral Score token"]
    , rules = ["All players who contributed to bandit defeat roll 3 dice and gain the gold" ]
    , jobs = [
        [on J.OnDefeatBandits , gain VP 3, J.Gain Gold (J.D 3)]
        ]
    }



