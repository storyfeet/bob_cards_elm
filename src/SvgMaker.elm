port module SvgMaker exposing (log,nextPage, main)

import Platform exposing (worker)
import PageSvg as Pg exposing (..)
import Player as PL
import PlayerSvg as PLSvg
import CardSvg exposing (..)
import Cards 
import Mission as MS
import MissionSvg 
import Decks.All exposing (allCards)
import MLists exposing(spreadL)
import Land 
import TileSvg



port log : Writer -> Cmd msg 
port nextPage : (Int -> msg) -> Sub msg

type alias Writer = { fname:String, content:String}



placeCard : Int -> String -> String
placeCard = placeCarder 3 0 210 297 50 70 Pg.LtoR

placeTile : Int -> String -> String
placeTile = placeCarder 3 0 210 297 45 45 Pg.LtoR

placePlayer: Pg.RowDirection -> Int -> String -> String
placePlayer rd= placeCarder 3 0 210 297 100 90 rd

placeMission : Int -> String -> String 
placeMission = placeCarder 3 0 210 297 200 72 Pg.LtoR



type alias Placer = (Int -> String -> String)

starterList : List Cards.Card
starterList = (allCards 5)
    |> spreadL 

populate: c -> Int -> List c
populate c n=
    case n of 
        0 -> []
        v -> c::(populate c (v - 1))

listPage :(c -> String)-> Placer ->List c -> String 
listPage fnt placer l =
    l |> List.map fnt 
    |> List.indexedMap placer
    |> String.join "\n"
    |> a4Page


type alias Model = 
    { p : Maybe Printer
    }

type Msg
    = Next

init : () -> (Model,Cmd Msg)
init _ = 
    ({p = multiPrinter printables |> Just}, Cmd.none)

update: Msg -> Model -> (Model,Cmd Msg)
update ms mod = 
    case ms of 
        Next -> updateNext mod


type alias Printer = () -> Printable

type Printable = 
    Continue (Writer,Printer)
    | Stop

updateNext: Model -> (Model, Cmd Msg)
updateNext m =
    case m.p of
        Nothing -> (m,Cmd.none)
        Just pr ->
            case pr () of 
                Continue (w,p) -> ({m | p = Just p},w |> log)
                Stop -> ({m | p = Nothing} ,Cmd.none)

   



pager : String -> Int -> List a -> Int -> (a -> String) -> Placer -> Printer
pager name pagenum list ncards fronter placer =
    \() -> case list of
        [] -> Stop
        _ -> let
                seg = List.take ncards list
                pg = listPage fronter placer seg
                rest = List.drop ncards list
                nm = (String.join "" [name ,String.fromInt pagenum |> String.padLeft 2 '0',".svg"])
            in
                Continue (Writer nm pg, pager name (pagenum + 1) rest ncards fronter placer )
            


multiPrinter : List Printer -> Printer 
multiPrinter lp =
    \() ->  case lp of
        [] -> Stop
        h::t -> case h () of 
            Continue (w,p) -> Continue (w, multiPrinter (p::t))
            Stop -> multiPrinter t ()


printables : List Printer
printables = 
    [ pager "cards" 0 starterList 16 CardSvg.front placeCard 
    , pager "card_backs" 0 ( populate () 16 ) 16 (\() ->CardSvg.back ) placeCard
    , pager "tiles" 0 Land.fullDeck 24 TileSvg.front placeTile
    , pager "tile_backs" 0 Land.fullDeck 24 TileSvg.back placeTile
    , pager "players" 0 PL.players 6 PLSvg.front (placePlayer Pg.LtoR)
    , pager "player_backs" 0 PL.players 6 PLSvg.back (placePlayer Pg.RtoL)
    , pager "missions" 0 MS.campaigns  4 MissionSvg.front placeMission
    , pager "mission_backs" 0 MS.campaigns 4 MissionSvg.back placeMission
    ]


            


{--
nextPlayer : Int -> List PL.Player -> Maybe Writer
nextPlayer = tryNextPage 6 PLSvg.front placePlayer "players"

nextPlayerBack : Int -> List PL.Player -> Maybe Writer
nextPlayerBack = tryNextPage 6 PLSvg.back placePlayerBack "playerback"
--}



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

