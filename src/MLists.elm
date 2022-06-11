module MLists exposing (..)
import Random
insertAt :Int -> a -> List a -> List a
insertAt pos v l =
    case (pos,l) of
        (_,[]) -> [v]
        (0, t) -> v::t
        (n,h::t) -> h::(insertAt (n - 1) v t )


insertSorted: (a -> a ->Bool) -> List a -> a -> List a
insertSorted f l v =
    case l of 
        [] -> [v]
        b::t -> if (f v b) 
                then b::(insertSorted f t v) 
                else v::b::t

sortL: (a -> a -> Bool) -> List a -> List a
sortL f l =
    case l of 
        [] -> []
        h::t -> insertSorted f (sortL f t) h

type alias NGen = Int -> Int -> (Int,Int)

shuffle: NGen -> Int-> List a -> List a
shuffle gf iseed l = 
    let (res ,_,_) = shuffleInner gf iseed l
    in res

shuffleInner:NGen -> Int -> List a -> (List a,Int ,Int)
shuffleInner gf iseed l =
    case l of
        [] -> ([],iseed ,0)
        h::t -> 
            let 
                (ls,seed,len) = shuffleInner gf iseed t
                (seed2,pos) = gf seed (len + 1)
            in
                (insertAt pos h ls ,seed2, len + 1)


rgen mul add top seed max =
    (Basics.modBy top ((seed * mul) + add) , Basics.modBy max seed)

rgen1 = rgen 293 31 311 
