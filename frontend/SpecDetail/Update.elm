module SpecDetail.Update exposing (..)

import SpecDetail.Messages exposing (Msg(..))
import SpecDetail.Models exposing (SpecDetail)
import Commands.Api exposing (fetchDetail)


update : Msg -> Maybe SpecDetail -> ( Maybe SpecDetail, Cmd Msg )
update message model =
    case message of
        OnFetchDetail (Ok newDetail) ->
            Debug.log "test1"
                ( Just newDetail, Cmd.none )

        OnFetchDetail (Err error) ->
            Debug.log "test2"
                ( model, Cmd.none )

        FetchDetail filepath ->
            ( model, fetchDetail filepath )
