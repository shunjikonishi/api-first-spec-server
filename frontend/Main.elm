module Main exposing (main)

import Html exposing (Html, div, text, program)
import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import Update exposing (update)
import View exposing (view)
import SpecList.Commands exposing (fetchAll)


init : ( Model, Cmd Msg )
init =
    let
        model =
            initialModel
    in
        ( model, Cmd.map SpecListMsg fetchAll )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
