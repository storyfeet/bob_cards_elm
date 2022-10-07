module MRand exposing (gnew,gzero,gnext,rgen1,rgen,GGen)
import Time exposing (Posix,posixToMillis)

rgen : Int -> Int -> Int -> Int ->Int -> (Int , Int)
rgen max mul add seed rmax =
    (Basics.modBy max ((seed * mul) + add) , Basics.modBy rmax seed)

rgen1: Int->Int->(Int,Int)
rgen1 = rgen ggmax ggmul ggadd
type alias GGen =
    { curr : Int
    , next : Int -> Int -> (Int,Int)
    }


gnext: GGen ->  Int -> (GGen ,Int)
gnext gen rmax =
    let 
        (rs,rn ) = gen.next gen.curr rmax
    in
        ({gen | curr= rs },rn)


gzero : GGen
gzero =
    { curr = 0
    , next = rgen1
    }
gnew : Posix -> GGen
gnew t = 
    { curr = posixToMillis t
    , next = rgen1
    }



ggmax :Int
ggmax = 21474836447
ggmul :Int
ggmul = 1604908823
ggadd :Int
ggadd = 1604872351




