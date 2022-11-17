port module SvgMaker exposing (log,nextPage, main)

import Platform exposing (worker)
import PageSvg exposing (..)
import Player as PL
import PlayerSvg as PLSvg
import CardSvg exposing (..)
import Cards exposing (..)
import Campaign as CP
import CampaignSvg as CPSvg
import Decks.All exposing (allCards)
import MLists exposing(spreadL)
import Land exposing (Tile)
import TileSvg



port log : Writer -> Cmd msg
port nextPage : (Int -> msg) -> Sub msg

type alias Writer = { fname:String, content:String}



placeCard : Int -> String -> String
placeCard = placeCarder 3 0 210 297 50 70 False

placeTile : Int -> String -> String
placeTile = placeCarder 3 0 210 297 45 45 False

placePlayer: Int -> String -> String
placePlayer = placeCarder 3 0 210 291 100 90 False

placePlayerBack: Int -> String -> String
placePlayerBack = placeCarder 3 0 210 291 100 90 True

type alias Placer = (Int -> String -> String)

starterList : List Card
starterList = (allCards 4)
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

backList : Placer -> Int -> String
backList placer n = 
    populate CardSvg.back n
    |> List.indexedMap placer
    |> String.join "\n"
    |> a4Page

type PrintMode
    = Cards
    | Tiles
    | Players
    | PlayerBacks
    | Campaign
    | CampaignBacks
    | Done

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
    case ms of 
        Next -> updateNext mod

updateNext : Model -> (Model,Cmd Msg)
updateNext mod = 
    case mod.pmode of 
        Cards -> case nextFront mod.pos starterList of
            Just w -> ({mod | pos = mod.pos +1}, w |> log)
            Nothing -> updateNext {mod | pos = 0 , pmode = Tiles}
        Tiles -> case nextTile mod.pos (Land.fullDeck ) of
            -- Do Backs and set to Done
            Just w -> ({mod | pos = mod.pos +1 }, w|> log)
            Nothing -> updateNext {mod | pos = 0, pmode = Players}
        Players -> case nextPlayer mod.pos PL.players of
            Just w -> ({mod | pos = mod.pos +1}, w|> log)
            Nothing -> updateNext {mod | pos = 0, pmode = PlayerBacks}
        PlayerBacks -> case nextPlayerBack mod.pos PL.players of
            Just w -> ({mod | pos = mod.pos +1}, w|> log)
            Nothing -> updateNext {mod | pos = 0, pmode = Campaign}
            -- GO Print Backs and say set to Done
        Campaign ->  case nextCampaign mod.pos CP.campaigns of
            Just w -> ({mod | pos = mod.pos +1}, w |> log)
            Nothing -> updateNext {mod | pos = 0, pmode = CampaignBacks }
        CampaignBacks -> case nextCampaignBack mod.pos CP.campaigns of 
            Just w -> ({mod | pos = mod.pos +1}, w|> log)
            Nothing -> ({mod | pmode = Done},Writer "backs.svg" (backList placeCard 16)|> log )
        Done -> (mod,Cmd.none)
            
     


tryNextPage : Int -> (a -> String) -> Placer -> String -> Int -> List a -> Maybe Writer
tryNextPage mul fronter placer name pos ls =
    case ls |> List.drop (pos * mul) |> List.take mul of 
        [] -> Nothing
        l -> l |> listPage fronter placer 
            |> Writer (String.join "" [name ,String.fromInt pos |> String.padLeft 2 '0',".svg"])
            |> Just
            

nextFront : Int->List Card -> Maybe Writer
nextFront = tryNextPage 16 front placeCard "front" 

nextTile : Int -> List Tile -> Maybe Writer
nextTile = tryNextPage 24 TileSvg.front placeTile "tiles"

nextPlayer : Int -> List PL.Player -> Maybe Writer
nextPlayer = tryNextPage 6 PLSvg.front placePlayer "players"

nextPlayerBack : Int -> List PL.Player -> Maybe Writer
nextPlayerBack = tryNextPage 6 PLSvg.back placePlayerBack "playerback"

nextCampaign : Int -> List CP.Campaign -> Maybe Writer
nextCampaign = tryNextPage 6 CPSvg.front placePlayer "campaignfront"

nextCampaignBack : Int -> List CP.Campaign -> Maybe Writer
nextCampaignBack = tryNextPage 6 CPSvg.back placePlayerBack "campaignback"
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

