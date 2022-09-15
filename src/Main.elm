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
import Canvas.Texture as CTex
import CardCanvas
import Dict exposing (Dict)
import HasPicList



type alias Model = 
    { pcards: Deck Card
    , tradeRow: Deck Card
    , gen : GGen 
    , textures : Dict String CTex.Texture
    }

init : Model
init = 
    { pcards = Deck.empty
    , tradeRow = Deck.empty
    , gen = gzero
    , textures = Dict.empty
    }



subscriptions: a -> Sub Msg
subscriptions _ = 
    Sub.none
    --Time.every 100000 Tick


-- VIEW
view : Model -> Html Msg
view m =
    div [] 
    [Cv.toHtmlWith { width= 500,height=400,textures=textures}  [
        style "border" "1px solid black"
        ] (m.pcards.hand 
        |> List.map (CardCanvas.front m.textures)
        |> List.indexedMap (\n x -> Cv.group 
            [ CvSA.transform 
                [ CvSA.Translate (150*(toFloat n)) 0
                , CvSA.Rotate (0.1*(toFloat n)) 
                ]
            ] [x]))
   ]

textures : List (CTex.Source Msg)
textures = HasPicList.pList 
    |> List.map (\x -> CTex.loadFromImageUrl ("pics/cards/" ++ x ++".svg") (Message.TexLoad x ))


-- UPDATE

update: Msg -> Model -> (Model ,Cmd Msg)
update mes mod =
    case mes of
        Message.NewGame t ->
            let
                gg = MRand.gnew t
                (gg1,trd) = Deck.fromNCardList gg 5 DkTrade.tradeDeck
                (gg2,pcards) = Deck.fromNCardList gg1 5 (DkStart.starterDeck  1)
            in 
                ({mod |
                gen = gg2
                , pcards = pcards
                ,tradeRow = trd
                
                },Cmd.none) 
        Message.TexLoad name (Just tex) -> 
                ({mod | textures = Dict.insert name tex mod.textures},Debug.log ("Texture Loaded "++name) Cmd.none)
        Message.TexLoad name Nothing -> 
                (mod,Debug.log ("Could not load image "++name) Cmd.none)


-- MAIN


main : Program () Model Msg
main = 
    Browser.element 
    { init = \_->(init,Task.perform Message.NewGame Time.now )
    , view =view 
    , subscriptions = subscriptions
    , update = update
    }
