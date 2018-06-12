module SpecListing.Update exposing(..)

import SpecListing.Messages exposing (Msg(..))
import SpecListing.Models exposing (SpecListing)

update : Msg -> List SpecListing -> ( List SpecListing, Cmd Msg )
update message specs =
  case message of
    OnFetchAll (Ok newSpecs) ->
      (newSpecs, Cmd.none)
    OnFetchAll (Err error) ->
      (specs, Cmd.none)
