module Decks.All exposing (allCards)
import Cards 
import Decks.Starter as ST
import Decks.Trade as TR
import Decks.Danger as DG

allCards :Int -> List (Cards.Card, Int)
allCards n = 
    ( ST.basicDeck n
    ++ TR.tradeDeck 
    ++ DG.dangerDeck n)
