module Decks.All exposing (allCards)
import Cards 
--import Decks.Starter as ST
import Decks.Trade as TR
import Decks.Danger as DG
import Player as PL

allCards :Int -> List (Cards.Card, Int)
allCards n = 
    ( PL.reqList n
    ++ TR.tradeDeck 
    ++ DG.dangerDeck n)
