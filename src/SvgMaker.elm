port module SvgMaker exposing (log, main)

import Platform exposing (worker)
import PageSvg exposing (..)
import CardSvg exposing (..)
import Cards exposing (..)

port log : String -> Cmd msg


main =
    worker
        { init = \() -> ( 0, "<HELLO>" |> a4Page|> log )
        , subscriptions = \_ -> Sub.none
        , update = \msg model -> ( model, Cmd.none )
        }

