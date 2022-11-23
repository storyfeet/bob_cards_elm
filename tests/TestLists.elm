module TestLists exposing (tSort,tInsert,tShuffle,tWordWrap,tWrap1)
import Test exposing (..)
import MRand
import Expect 
import MLists


pre : List Int
pre = [4,5,6,3,2,3]
post : List Int
post = [2,3,3,4,5,6]

sortNums : List comparable -> List comparable
sortNums = 
    MLists.sortL (\a b -> a > b)

tSort : Test
tSort = 
    test "Can I sort a list of numbers"
    (\_ -> Expect.equal (sortNums pre) post)

tInsert : Test
tInsert = 
    test "Can I insert Where I want"
    (\_ -> Expect.equal (MLists.insertAt 3 "d" ["a","b","c","e"]) ["a","b","c","d","e"])



tShuffle : Test
tShuffle =
    test "Can I Shuffle a list"
    (\_ -> Expect.equal [4,6,3,1,5,2] (MLists.shuffle (MRand.gzero)  [1,2,3,4,5,6]) )



tWrap1 : Test
tWrap1 = test "Wrap1 line"
    (\_ -> Expect.equal (MLists.wrap1_ 7 (String.toList "hello cat people") ""  ) (Just ("hello" ,String.toList "cat people" )))

tWordWrap : Test
tWordWrap
    = test "Wordwrap does anything"
    (\_ -> Expect.equal (MLists.wordWrap "--" 9 "Hello cat people" ) ["Hello cat" ,"--people"])
