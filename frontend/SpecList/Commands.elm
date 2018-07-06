module SpecList.Commands exposing (..)

import Http
import Json.Decode as Decode exposing (field)
import SpecListing.Models exposing (SpecListing)
import SpecList.Messages exposing (..)


fetchAll : Cmd Msg
fetchAll =
    Http.get fetchAllUrl collectionDecoder
        |> Http.send OnFetchAll


fetchAllUrl =
    "/api/specs"


collectionDecoder : Decode.Decoder (List SpecListing)
collectionDecoder =
    Decode.list memberDecoder


memberDecoder : Decode.Decoder SpecListing
memberDecoder =
    Decode.map5 SpecListing
        (field "filepath" Decode.string)
        (field "endpoint" Decode.string)
        (field "method" Decode.string)
        (field "name" Decode.string)
        (Decode.maybe <| field "description" Decode.string)
