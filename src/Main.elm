module Main exposing(..)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Time
import Task

import Decks.Starter as DkStart
import Decks.Trade as DkTrade
import Cards exposing (Card)
import Deck exposing (Deck)
import MRand exposing (GGen,gzero)
import Message exposing (Msg)
import Canvas as Cv
import Canvas.Settings as Cvs
import Color


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



subscriptions: a -> Sub Msg
subscriptions _ = 
    Sub.none
    --Time.every 100000 Tick


-- VIEW
view : Model -> Html Msg
view _ = 
    div [] 
    [Cv.toHtml (500,400) [
        style "border" "1px solid black"
        ] [
            Cv.shapes [Cvs.fill Color.green] [
                    Cv.rect (50,10) 300 300
                ]
            ]
        -- div [style "clear" "both"] ((text "Hand")::(mod.pcards.hand |> List.map Cards.view))
    --, div [style "clear" "both"] ((text "TradeRow")::(mod.tradeRow.hand |> List.map Cards.view))
    --, Map.view
   ]




-- UPDATE

update: Msg -> Model -> (Model ,Cmd Msg)
update mes _ =
    case mes of
        Message.NewGame t ->
            let
                gg = MRand.gnew t
                (gg1,trd) = Deck.fromNCardList gg 5 DkTrade.tradeDeck
                (gg2,pcards) = Deck.fromNCardList gg1 5 (DkStart.starterDeck  1)
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
