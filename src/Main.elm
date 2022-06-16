module Main exposing(..)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Time
import MLists 
import Task
import Cards exposing (Card,tradeRow)
import Deck exposing (Deck)
import MRand exposing (GGen,gnext)


type alias Model = 
    { pcards: Deck Card
    , tradeRow: Deck Card
    , gen : GGen 
    }

init : Model
init = 
    { pcards = Deck.new 
    , time = 0
    }


type Msg = 
    NewGame Time.Posix

subscriptions _ = 
    Sub.none
    --Time.every 100000 Tick


-- VIEW
view mod = 
   let 
       ls = mod.deck |>  MLists.shuffle MLists.rgen1 mod.time 
   in p [] (ls |> List.map Cards.view )


-- UPDATE

update: Msg -> Model -> (Model ,Cmd Msg)
update mes mod =
    case mes of
        NewGame t ->
            let d = tradeRow |> MLists.spreadL |> MLists.shuffle MLists.rgen1 (Time.posixToMillis t)
            in
            ({ mod 
            | time= Time.posixToMillis t 
            , deck = d
            } , Cmd.none)

-- MAIN


main : Program () Model Msg
main = 
    Browser.element 
    { init = \_->(init,Task.perform NewGame Time.now )
    , view =view 
    , subscriptions = subscriptions
    , update = update
    }
