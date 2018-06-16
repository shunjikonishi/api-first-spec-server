module SpecListing.Commands exposing (..)

import Http
import Json.Decode as Decode exposing (field)
import Task
import SpecListing.Models exposing (SpecListing)
import SpecListing.Messages exposing (..)


fetchAll : Cmd Msg
fetchAll =
    Http.get fetchAllUrl collectionDecoder
        |> Http.send OnFetchAll


fetchAllUrl =
    "http://localhost:7000/api/specs"


collectionDecoder : Decode.Decoder (List SpecListing)
collectionDecoder =
    Decode.list memberDecoder


memberDecoder : Decode.Decoder SpecListing
memberDecoder =
    Decode.map4 SpecListing
        (field "endpoint" Decode.string)
        (field "method" Decode.string)
        (field "name" Decode.string)
        (Decode.maybe <| field "description" Decode.string)
