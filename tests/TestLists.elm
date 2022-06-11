module TestLists exposing (tSort,tInsert,tShuffle,tRandomList)
import Test exposing (..)
import Expect 
import MLists


pre = [4,5,6,3,2,3]
post = [2,3,3,4,5,6]

sortNums = 
    MLists.sortL (\a b -> a > b)

tSort = 
    test "Can I sort a list of numbers"
    (\_ -> Expect.equal (sortNums pre) post)

tInsert = 
    test "Can I insert Where I want"
    (\_ -> Expect.equal (MLists.insertAt 3 "d" ["a","b","c","e"]) ["a","b","c","d","e"])


ngen mul add top seed max =
    (Basics.modBy top ((seed * mul) + add) , Basics.modBy max seed)

ngensimp =
    ngen 293 31 311 

tShuffle =
    test "Can I Shuffle a list"
    (\_ -> Expect.equal [6,2,3,5,1,4] (MLists.shuffle ngensimp 104 [1,2,3,4,5,6]) )


randomList: MLists.NGen -> Int-> Int -> (List Int,Int)
randomList gf seed len =
    case len of 
        0 -> ([] , seed)
        _ -> 
            let
                (small,seed2) = randomList gf seed (len - 1)
                (seed3 ,v) = gf seed2 len
            in
                (v::small ,seed3)

tRandomList 
    = test "randomList does thing"
    (\_ -> Expect.equal ([12,11,14,10,9,9,1,4,1,9,2,7,0,3,0,4,2,0,1,0],28) (randomList ngensimp 102 20))



