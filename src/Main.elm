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
import Canvas.Settings.Advanced as CvSA
import CardCanvas


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
view m =
    div [] 
    [Cv.toHtml (500,400) [
        style "border" "1px solid black"
        ] (m.pcards.hand 
        |> List.map CardCanvas.front
        |> List.indexedMap (\n x -> Cv.group 
            [ CvSA.transform 
                [ CvSA.Translate (150*(toFloat n)) 0
                , CvSA.Rotate (0.1*(toFloat n)) 
                ]
            ] [x]))
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
