module Main exposing(..)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Time


type alias Model = 
    { deck : List Int
    }

init = 
    { deck = [1,2,3,4,5,6]

    }

type Msg = Tick Time.Posix

subscriptions _ = 
    Time.every 1000 Tick


main : Program () Model Msg
main = 
    Browser.element 
    { init = \_->(init,Cmd.none)
    , view = (\_ ->p [] [text "poo"])
    , subscriptions = subscriptions
    , update = (\_ mod -> (mod, Cmd.none))
    }
