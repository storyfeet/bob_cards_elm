port module SvgMaker exposing (log,nextPage, main)

import Platform exposing (worker)
import PageSvg exposing (..)
import CardSvg exposing (..)
import Cards exposing (..)
import MLists exposing(spreadL)
import Land exposing (Tile)
import TileSvg


port log : Writer -> Cmd msg
port nextPage : (Int -> msg) -> Sub msg

type alias Writer = { fname:String, content:String}



placeCard : Int -> String -> String
placeCard = placeCarder 3 0 210 297 50 70

placeTile : Int -> String -> String
placeTile = placeCarder 3 0 210 297 45 45 

type alias Placer = (Int -> String -> String)

starterList : List Card
starterList = (starterDeck ++ tradeRow ++ playerDeck)
    |> spreadL 

listPage :(c -> String)-> Placer ->List c -> String 
listPage fnt placer l =
    l |> List.map fnt 
    |> List.indexedMap placer
    |> String.join "\n"
    |> a4Page


type PrintMode
    = Cards
    | Tiles

type alias Model = 
    { pmode:PrintMode
    , pos:Int
    }

type Msg
    = Next

init : () -> (Model,Cmd Msg)
init _ = 
    ({pos=0,pmode = Cards } , Cmd.none)

update: Msg -> Model -> (Model,Cmd Msg)
update ms mod = 
    case (ms,mod.pmode) of 
        (Next, Cards) -> case nextFront mod.pos starterList of
            Nothing -> update Next {mod | pos = 0 , pmode = Tiles}
            Just w -> ({mod | pos = mod.pos +1}, w |> log)
        (Next, Tiles) -> case nextTile mod.pos (Land.fullDeck ) of
            Nothing -> (mod,Cmd.none)
            Just w -> ({mod | pos = mod.pos +1 }, w|> log)
            

tryNextPage : Int -> (a -> String) -> Placer -> String -> Int -> List a -> Maybe Writer
tryNextPage mul fronter placer name pos ls =
    case ls |> List.drop (pos * mul) |> List.take mul of 
        [] -> Nothing
        l -> l |> listPage fronter placer 
            |> Writer (String.join "" [name ,String.fromInt pos,".svg"])
            |> Just
            

nextFront : Int->List Card -> Maybe Writer
nextFront = tryNextPage 16 front placeCard "front" 

nextTile : Int -> List Tile -> Maybe Writer
nextTile = tryNextPage 24 TileSvg.front placeTile "tiles"

subscriptions : Model -> Sub Msg
subscriptions _ =
    nextPage (\_ -> Next)


main : Program () Model Msg
main =
    worker
        { init = init --( Model, starterPage |> a4Page|>  Writer "out1.svg" |> log )
        , subscriptions = subscriptions
        , update = update
        }

