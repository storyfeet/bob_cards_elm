module Message exposing (..)
import Time exposing(Posix)
import Canvas.Texture as CTex
type Msg = 
    NewGame Posix
    | TexLoad String (Maybe CTex.Texture)

