module MLists exposing (..)
import MRand exposing(..)

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



shuffle: GGen  -> List a -> List a
shuffle gf l = 
    let (res ,_,_) = shuffleInner gf l
    in res

shuffleInner:GGen  -> List a -> (List a,GGen  ,Int)
shuffleInner gg l =
    case l of
        [] -> ([],gg ,0)
        h::t -> 
            let 
                (ls,gg1,len) = shuffleInner gg t
                (gg2,pos) = gnext gg1 (len + 1)
            in
                (insertAt pos h ls ,gg2, len + 1)


spreadItem: (a,Int) -> List a -> List a
spreadItem (a,n) l =
    case n of 
        0 -> l
        _ -> spreadItem (a ,n - 1) (a::l)


spreadL: List (a, Int)-> List a
spreadL l =
    case l of
        [] -> []
        (a,n)::t->spreadItem (a,n) (spreadL t) 


