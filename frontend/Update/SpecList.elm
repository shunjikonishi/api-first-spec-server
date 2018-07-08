module Update.SpecList exposing (..)

import Models.SpecList exposing (SpecList, Msg(..))
import Commands.Api exposing (reset)


update : Msg -> SpecList -> ( SpecList, Cmd Msg )
update message model =
    case message of
        OnFetchAll (Ok newSpecs) ->
            ( { model | list = newSpecs }, Cmd.none )

        OnFetchAll (Err error) ->
            ( model, Cmd.none )

        OnFilter str ->
            ( { model | filter = str }, Cmd.none )

        Reset ->
            ( model, reset )
