module Sorting.Update exposing (..)

import Sorting.Messages exposing (Msg(..))
import Sorting.Models exposing (Sorting)
import SpecListing.Commands exposing (fetchAll)
import SpecListing.Messages


update : Msg -> Sorting -> ( Sorting, Cmd SpecListing.Messages.Msg )
update message sorting =
    case message of
        OnSpecListSort sorting ->
            ( sorting, fetchAll sorting )
