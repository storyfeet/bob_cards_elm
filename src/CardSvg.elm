module CardSvg exposing (..)

import Cards exposing(..)

svgWrap : String -> String
svgWrap m = 
    """<svg version="1.1" 
    width="210mm" 
    height="297mm" 
    viewBox="0 0 210 297" 
    xmlns="http://www.w3.org/2000/svg"
    >
    """ ++ m ++ "</svg>"

nCardsFit : Float -> Float -> Float -> Float -> Int
nCardsFit margin padding page card =
    (page - (margin *2))  / (card + padding ) |> floor

nFitPage : Float -> Float -> Float -> Float -> Float -> Float -> Int
nFitPage margin padding pw ph cw ch =
    (nCardsFit margin padding pw cw) *(nCardsFit margin padding ph ch)

placeOneDir  : Int -> Float -> Float -> Float -> Int -> Float
placeOneDir numCards padding page card n =
    let 
        start = (page - (numCards * card) - (numCards - 1) * padding) / 2
        step = card + padding
    in
        start + n * step

        

placeCard : Float -> Float -> Float -> Float -> Float -> Float -> Int -> String -> String
placeCard margin padding pW pH cW cH n theCard = 
    let 
        nwide = nCardsFit margin padding pW cW
        x = modBy nwide n
        y = n // nwide
        xp = placeOneDir margin padding pW cW x
        yp = placeOneDir margin padding pH cH y
        in 
        String.join [
            """<g transform="translate("""
            , (fromInt xp) 
            , "," 
            , """)">""" 
            , theCard 
            , "</g>"
        ]
    

