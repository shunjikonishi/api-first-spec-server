module SpecList.Update exposing (..)

import SpecList.Messages exposing (Msg(..))
import SpecList.Models exposing (SpecList)
import Sorting.Models exposing (Sorting)
import SpecList.Commands exposing (fetchAll)


update : Msg -> SpecList -> ( SpecList, Cmd Msg )
update message model =
    case message of
        OnFetchAll (Ok newSpecs) ->
            ( { model | list = newSpecs }, Cmd.none )

        OnFetchAll (Err error) ->
            ( model, Cmd.none )

        OnFilter str ->
            ( { model | filter = str }, Cmd.none )
