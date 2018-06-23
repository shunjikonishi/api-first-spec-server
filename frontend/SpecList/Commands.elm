module SpecList.Commands exposing (..)

import Http
import Json.Decode as Decode exposing (field)
import SpecListing.Models exposing (SpecListing)
import SpecList.Messages exposing (..)
import Sorting.Models exposing (Sorting)


fetchAll : Sorting -> Cmd Msg
fetchAll sorting =
    let
        query =
            "?sort.field=" ++ sorting.field ++ "&sort.direction=" ++ (toString sorting.direction |> String.toLower)
    in
        Http.get (fetchAllUrl ++ query) collectionDecoder
            |> Http.send OnFetchAll


fetchAllUrl =
    "/api/specs"


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
