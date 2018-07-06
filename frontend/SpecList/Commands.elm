module SpecList.Commands exposing (..)

import Http
import SpecListing.Models exposing (specListingArrayDecoder)
import SpecList.Messages exposing (..)


fetchAll : Cmd Msg
fetchAll =
    Http.get fetchAllUrl specListingArrayDecoder
        |> Http.send OnFetchAll


fetchAllUrl =
    "/api/specs"
