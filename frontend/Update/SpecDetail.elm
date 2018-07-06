module Update.SpecDetail exposing (..)

import Models.SpecDetail exposing (SpecDetail, Msg(..))
import Commands.Api exposing (fetchDetail)


update : Msg -> Maybe SpecDetail -> ( Maybe SpecDetail, Cmd Msg )
update message model =
    case message of
        OnFetchDetail (Ok newDetail) ->
            ( Just newDetail, Cmd.none )

        OnFetchDetail (Err error) ->
            ( model, Cmd.none )

        FetchDetail filepath ->
            ( model, fetchDetail filepath )
