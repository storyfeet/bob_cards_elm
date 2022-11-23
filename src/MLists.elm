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
    let (_,res ,_) = shuffleInner gf l
    in res

shuffleInner:GGen  -> List a -> (GGen,List a  ,Int)
shuffleInner gg l =
    case l of
        [] -> (gg ,[],0)
        h::t -> 
            let 
                (gg1,ls,len) = shuffleInner gg t
                (gg2,pos) = gnext gg1 (len + 1)
            in
                (gg2, insertAt pos h ls , len + 1)


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


    
mapEnumerated_ : (Int-> v -> t)-> Int ->List v -> List t
mapEnumerated_ f n l =
    case l of 
        [] -> []
        h::t -> (f n h ) :: (mapEnumerated_ f (n + 1) t)

mergeIfSmaller: Int -> List a -> List a  -> List a
mergeIfSmaller n a b =
    if (List.length a) + ( List.length b) > n 
    then if a == [] then b else a
    else a ++ b
    

wordWrap : String -> Int -> String -> List String
wordWrap sub n s =
    wordWrap_ (String.toList sub) n (String.toList s)

wordWrap_: List Char -> Int -> List Char ->  List String
wordWrap_ sub n s = 
    case wrap1_ n s "" of
        Just (w1, []) -> [w1]
        Just (w1 , rest ) -> w1 :: (wordWrap_ sub n (sub ++ rest) )
        Nothing -> [String.fromList s] 


wrap1_ : Int -> List Char -> String -> Maybe (String,List Char)
wrap1_ n s bld =
    case s of
        [] -> Just (bld , [])
        ' '::t -> case wrap1_ (n - 1) t (bld++" ") of 
            Just v -> Just v
            Nothing -> Just ( bld, t)
        '\n'::t -> Just (bld, t)
        c::t -> if n <= 0 then Nothing
            else wrap1_ (n - 1) t (bld ++ String.fromChar c)

            

    


