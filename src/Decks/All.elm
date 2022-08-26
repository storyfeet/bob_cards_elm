module Decks.All exposing (..)
import Cards 
import Decks.Starter as ST
import Decks.Trade as TR
allCards : List (Cards.Card, Int)
allCards = 
    ( ST.starterDeck 
    ++ TR.tradeDeck 
    ++ ST.playerDeck 
    ++ ST.dangerDeck)
