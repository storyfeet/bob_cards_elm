port module SvgMaker exposing (log, main)

import Platform exposing (worker)
import PageSvg exposing (..)
import CardSvg exposing (..)
import Cards exposing (..)
import MLists exposing(spreadL)

port log : String -> Cmd msg


a444 = placeCarder 3 0 210 297 50 70
starterPage = starterDeck 
    |> spreadL 
    |> List.map front 
    |> List.indexedMap (\n c -> a444 n c)
    |> String.join "\n"


main =
    worker
        { init = \() -> ( 0, starterPage |> a4Page|> log )
        , subscriptions = \_ -> Sub.none
        , update = \msg model -> ( model, Cmd.none )
        }

