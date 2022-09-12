module Decks.All exposing (allCards)
import Cards 
import Decks.Starter as ST
import Decks.Trade as TR

allCards :Int -> List (Cards.Card, Int)
allCards n = 
    ( ST.starterDeck n
    ++ TR.tradeDeck 
    ++ ST.playerDeck 
    ++ ST.dangerDeck n)
