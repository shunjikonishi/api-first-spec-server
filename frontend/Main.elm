module Main exposing(main)

import Html exposing (Html, div, text, program)
import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import Update exposing (update)
import View exposing (view)

import SpecListing.Commands exposing (fetchAll)

init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.map SpecListingMsg fetchAll )

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

-- MAIN

main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }