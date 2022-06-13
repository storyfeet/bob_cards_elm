module Css exposing (..)
import Html
import Html.Attributes exposing (..)

cardStyle: String -> List (Html.Attribute msg)
cardStyle col = 
    [ style "background-color" col
    , style "border" "1px solid black"
    , style "margin" "5px"
    , style "width" "200px"
    , style "height" "320px"
    , style "float" "left"
    , style "position" "relative"
    , style "transform" "rotate(20deg)"
    ]

hexStyle: String -> Int -> List (Html.Attribute msg)
hexStyle col sz = 
    let ss = String.fromInt sz ++ "px"
    in
    [ style "background-color" col
    , style "clip-path" "polygon(20% 0%, 80% 0%, 100% 50%,80% 100%, 20% 100%, 0% 50% )"
    , style "width" ss
    , style "height" ss
    , style "padding" "3px"
    , style "text-align" "center"
    ]
