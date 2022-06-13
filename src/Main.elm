module Main exposing(..)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Time
import MLists
import Task
import Cards exposing (Card,tradeRow)


type alias Model = 
    { deck : List Card
    , time: Int
    }

init = 
    { deck = MLists.spreadL tradeRow
    , time = 0
    }


type Msg = Tick Time.Posix

subscriptions _ = 
    Time.every 10000 Tick


-- VIEW
view mod = 
   let 
       ls = mod.deck |>  MLists.shuffle MLists.rgen1 mod.time 
   in p [] (ls |> List.map Cards.view )


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
