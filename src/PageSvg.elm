module PageSvg exposing (..)


pageWrap : String -> Int -> Int -> String -> String
pageWrap u w h  m  = 
    String.join "" 
    [ """<svg version="1.1" 
        width=\""""
        , w |> String.fromInt
        , u
        , "\" height=\""
        , h |> String.fromInt
        , u 
        , """\" viewBox="0 0 210 297" 
            xmlns="http://www.w3.org/2000/svg"
            > 
        """
        , m
        , "\n</svg>"
    ]

etag : String -> List String -> String
etag name props =
    "<" ++ name ++ " " ++ (String.join " " props) ++ " />"


tag : String -> List String -> List String -> String
tag name props children =
    "<" ++ name ++ " " ++ (String.join " " props) ++ " >" ++ String.join "\n" children ++ "</" ++ name ++ ">"



a4Page : String -> String
a4Page = pageWrap "mm" 210 297

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




