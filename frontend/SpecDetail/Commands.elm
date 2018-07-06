module SpecDetail.Commands exposing (..)

import Http
import SpecDetail.Models exposing (specDetailDecoder)
import SpecDetail.Messages exposing (..)


fetchDetail : String -> Cmd Msg
fetchDetail filepath =
    Http.get (fetchDetailUrl ++ filepath) specDetailDecoder
        |> Http.send OnFetchDetail


fetchDetailUrl =
    "/api/specs"
