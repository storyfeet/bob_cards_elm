module Main exposing(..)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Time
import MLists 
import Task
import Cards exposing (Card,tradeRow,starterDeck)
import Deck exposing (Deck)
import MRand exposing (GGen,gzero,rgen1)
import Message exposing (Msg)
import Map


type alias Model = 
    { pcards: Deck Card
    , tradeRow: Deck Card
    , gen : GGen 
    }

init : Model
init = 
    { pcards = Deck.empty
    , tradeRow = Deck.empty
    , gen = gzero
    }



subscriptions _ = 
    Sub.none
    --Time.every 100000 Tick


-- VIEW
view : Model -> Html Msg
view mod = 
    div [] 
    [ div [style "clear" "both"] ((text "Hand")::(mod.pcards.hand |> List.map Cards.view))
    , div [style "clear" "both"] ((text "TradeRow")::(mod.tradeRow.hand |> List.map Cards.view))
    --, Map.view
   ]




-- UPDATE

update: Msg -> Model -> (Model ,Cmd Msg)
update mes _ =
    case mes of
        Message.NewGame t ->
            let
                gg = MRand.gnew t
                (gg1,trd) = Deck.fromNCardList gg 5 tradeRow
                (gg2,pcards) = Deck.fromNCardList gg1 5 starterDeck 
            in 
                ({ gen = gg2
                , pcards = pcards
                ,tradeRow = trd
                },Cmd.none) 
                


-- MAIN


main : Program () Model Msg
main = 
    Browser.element 
    { init = \_->(init,Task.perform Message.NewGame Time.now )
    , view =view 
    , subscriptions = subscriptions
    , update = update
    }
