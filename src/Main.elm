module Main exposing(..)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Time
import MLists
import Task


type alias Model = 
    { deck : List Int
    , time: Int
    }

init = 
    { deck = [1,2,3,4,5,6]
    , time = 0
    }


type Msg = Tick Time.Posix

subscriptions _ = 
    Time.every 1000 Tick


-- VIEW
view mod = 
   let 
       ls = mod.deck |>  MLists.shuffle MLists.rgen1 mod.time 
   in p [] (ls |> List.map (\s->s|>String.fromInt|> text))


-- UPDATE

update mes mod =
    case mes of
        Tick t -> ({mod |time= Time.posixToMillis t},Cmd.none)

-- MAIN


main : Program () Model Msg
main = 
    Browser.element 
    { init = \_->(init,Cmd.none)
    , view =view 
    , subscriptions = subscriptions
    , update = update
    }
