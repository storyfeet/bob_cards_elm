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

itemStyle: List (Html.Attribute msg) -> List (Html.Attribute msg)
itemStyle l = 
    (style "margin" "3px")::( style "float" "left")::l

circleStyle: String -> Int -> List (Html.Attribute msg)
circleStyle col sz = 
    let ss = String.fromInt sz ++ "px"
    in
    [ style "background-color" col
    , style "clip-path" "circle(50% at 50% 50%)"
    , style "width" ss
    , style "height" ss
    , style "padding" "3px"
    , style "text-align" "center"
    ]

drawCardStyle: String -> Int -> Int -> List (Html.Attribute msg)
drawCardStyle col w h =
    let
        sw = (String.fromInt w) ++ "px" 
        sh = (String.fromInt h) ++ "px"
    in
    [ style "background-color" "blue"
    , style "border-radius" "10%"
    , style "border" "2px solid black"
    , style "color" col
    , style "width" sw
    , style "height" sh
    , style "text-align" "right"
    , style "font-size" "2em"
    , style "margin" "3px"
    , style "float" "left"
    ]

squareStyle: String -> Int -> List (Html.Attribute msg)
squareStyle col s =
    let
        sh = (String.fromInt s) ++ "px"
    in
    [ style "background-color" col
    , style "border" "2px solid black"
    , style "width" sh
    , style "height" sh
    , style "margin" "3px"
    , style "text-align" "center"
    , style "float" "left"
    ]
