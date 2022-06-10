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


ngen mul top add seed max =
    (Basics.modBy top ((seed * mul) + add) , Basics.modBy max seed)

ngensimp =
    ngen 291 311 31

tShuffle =
    test "Can I Shuffle a list"
    (\_ -> Expect.equal (MLists.shuffle ngensimp 102 [1,2,3,4,5,6]) [2,5,3,6,1,4])


randomList: MLists.NGen -> Int-> Int -> (List Int,Int)
randomList gf seed len =
    case len of 
        0 -> ([] , 0)
        _ -> 
            let
                (small,seed2) = randomList gf seed (len - 1)
                (seed3 ,v) = gf seed2 len
            in
                (v::small ,seed3)

tRandomList 
    = test "randomList does thing"
    (\_ -> Expect.equal (randomList ngensimp 102 6) ([2,1,0,0,1,0],13))



