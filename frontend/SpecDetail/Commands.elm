module SpecDetail.Commands exposing (..)

import Http
import Json.Decode as Decode exposing (field)
import SpecDetail.Models exposing (..)
import SpecDetail.Messages exposing (..)


fetchDetail : String -> Cmd Msg
fetchDetail filepath =
    Http.get (fetchDetailUrl ++ filepath) specDecoder
        |> Http.send OnFetchDetail


fetchDetailUrl =
    "/api/specs"


specDecoder : Decode.Decoder SpecDetail
specDecoder =
    Decode.map8 SpecDetail
        (field "filepath" Decode.string)
        (field "name" Decode.string)
        (field "method" Decode.string)
        (field "endpoint" Decode.string)
        (Decode.maybe <| field "description" Decode.string)
        (field "urlParams" (Decode.list Decode.string))
        (Decode.maybe <| field "request" requestDecoder)
        (Decode.maybe <| field "response" responseDecoder)


requestDecoder : Decode.Decoder Request
requestDecoder =
    Decode.map4 Request
        (field "strict" Decode.bool)
        (field "contentType" Decode.string)
        (Decode.maybe <| field "headers" (Decode.dict Decode.string))
        (Decode.maybe <| field "params" (Decode.dict paramDecoder))


responseDecoder : Decode.Decoder Response
responseDecoder =
    Decode.map4 Response
        (field "strict" Decode.bool)
        (field "contentType" Decode.string)
        (Decode.maybe <| field "headers" (Decode.dict Decode.string))
        (Decode.maybe <| field "data" (Decode.dict paramDecoder))


paramDecoder : Decode.Decoder Param
paramDecoder =
    Decode.map5 Param
        (field "name" Decode.string)
        (field "type" Decode.string)
        (field "isArray" Decode.bool)
        (field "rules" (Decode.list ruleDecoder))
        (field "children" (Decode.dict paramChildDecoder))


paramChildDecoder : Decode.Decoder ParamChild
paramChildDecoder =
    Decode.map ParamChild (Decode.lazy (\_ -> paramDecoder))


ruleDecoder : Decode.Decoder Rule
ruleDecoder =
    Decode.map2 Rule
        (field "name" Decode.string)
        (field "param" Decode.string)
