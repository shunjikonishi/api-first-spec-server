module SpecDetail.Update exposing (..)

import SpecDetail.Messages exposing (Msg(..))
import SpecDetail.Models exposing (SpecDetail)
import SpecDetail.Commands exposing (fetchDetail)


update : Msg -> Maybe SpecDetail -> ( Maybe SpecDetail, Cmd Msg )
update message model =
    case message of
        OnFetchDetail (Ok newDetail) ->
            ( Just newDetail, Cmd.none )

        OnFetchDetail (Err error) ->
            ( model, Cmd.none )

        FetchDetail filepath ->
            ( model, fetchDetail filepath )
