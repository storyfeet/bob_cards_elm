module PageSvg exposing (..)


a4Page : String -> String
a4Page = pageWrap "mm" 210 297
pageWrap : String -> Int -> Int -> String -> String
pageWrap u w h  m  = 
    tag "svg" [iunit w u |> prop "width"
        , iunit h u |> prop "height"
        , prop "xmlns" "http://www.w3.org/2000/svg"
        , prop "viewBox" ("0 0 "++ String.fromInt w ++ " " ++ String.fromInt h)
    ] [m]

----  TAGS ----

etag : String -> List String -> String
etag name propl =
    "<" ++ name ++ " " ++ (String.join " " propl) ++ " />"


tag : String -> List String -> List String -> String
tag name propl children =
    "<" ++ name ++ " " ++ (String.join " " propl) ++ " >" ++ String.join "\n" children ++ "</" ++ name ++ ">"

rect: Float -> Float -> Float -> Float -> List String -> String
rect x y w h pps =
    etag "rect" ((xywh x y w h)::pps)

---- Properties -----

prop : String -> String -> String
prop name val = 
    name ++ "=\"" ++ val ++ "\""
fprop : String -> Float -> String
fprop name val = 
    prop name (String.fromFloat val)

funit : Float -> String -> String
funit n u =
    String.fromFloat n ++ u

iunit : Int -> String -> String
iunit n u =
    String.fromInt n ++ u


iprop : String -> Int -> String
iprop name val =
    prop name (String.fromInt val)

props : List String -> String
props =
    String.join " "

xy : Float -> Float -> String
xy x y =
    props [ fprop "x" x , fprop "y" y]

wh : Float -> Float -> String
wh w h =
    props [ fprop "width" w , fprop "height" h]
xywh : Float -> Float -> Float -> Float -> String
xywh x y w h =
    props [xy x y, wh w h]

flstk : String -> String -> Float ->String
flstk f s w =
    props 
    [ prop "fill" f
    , prop "stroke" s
    , fprop "stroke-width" w
    ]

---- Layout ---- 

nCardsFit : Float -> Float -> Float -> Float -> Int
nCardsFit margin padding page card =
    (page - (margin *2))  / (card + padding ) |> floor

nFitPage : Float -> Float -> Float -> Float -> Float -> Float -> Int
nFitPage margin padding pw ph cw ch =
    (nCardsFit margin padding pw cw) *(nCardsFit margin padding ph ch)

placeOneDir  : Int -> Float -> Float -> Float -> Int -> Float
placeOneDir numCards padding page card n =
    let 
        nf = toFloat numCards
        start = (page - nf * card - (nf - 1) * padding) / 2
        step = card + padding
    in
        start + toFloat n * step

placeCarder : Float -> Float -> Float -> Float -> Float ->Float -> Int -> String -> String
placeCarder margin padding pw ph cw ch =
    let 
        nwide = nCardsFit margin padding pw cw
        nhigh = nCardsFit margin padding ph ch
        fx = placeOneDir nwide padding pw cw
        fy = placeOneDir nhigh padding ph ch
    in 
        placeCardF nwide fx fy

        
placeCardF : Int -> (Int -> Float) -> (Int -> Float) -> Int -> String -> String
placeCardF nwide fx fy n theCard=
    let
        x = modBy nwide n
        y = n // nwide
    in
        String.join "" [
            """<g transform="translate("""
            , x |> fx |> String.fromFloat 
            , "," 
            , y |> fy |> String.fromFloat
            , """)">""" 
            , theCard 
            , "</g>"
        ]




