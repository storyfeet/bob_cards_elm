port module SvgMaker exposing (log,nextPage, main)

import Platform exposing (worker)
import PageSvg exposing (..)
import CardSvg exposing (..)
import Cards exposing (..)
import MLists exposing(spreadL)


port log : Writer -> Cmd msg
port nextPage : (Int -> msg) -> Sub msg

type alias Writer = { fname:String, content:String}



placeCard : Int -> String -> String
placeCard = placeCarder 3 0 210 297 50 70



starterList = (starterDeck ++ tradeRow)
    |> spreadL 

listPage :List Card -> String 
listPage l =
    l |> List.map front 
    |> List.indexedMap (\n c -> placeCard n c)
    |> String.join "\n"
    |> a4Page



type alias Model = {pos:Int}

type Msg
    = Args 
    | Next

init : () -> (Model,Cmd Msg)
init _ = 
    ({pos=0} , Cmd.none)

update: Msg -> Model -> (Model,Cmd Msg)
update ms mod = 
    case ms of 
        Next -> ({mod | pos = mod.pos + 16}, 
            case starterList |> List.drop mod.pos |> List.take 16 of
                [] -> Cmd.none
                l -> l 
                    |> listPage 
                    |> Writer ("out" ++String.fromInt mod.pos ++".svg") 
                    |> log
            )
        Args -> (mod, Cmd.none) 



subscriptions : Model -> Sub Msg
subscriptions _ =
    nextPage (\_ -> Next)


main : Program () Model Msg
main =
    worker
        { init = init --( Model, starterPage |> a4Page|>  Writer "out1.svg" |> log )
        , subscriptions = subscriptions
        , update = update
        }

