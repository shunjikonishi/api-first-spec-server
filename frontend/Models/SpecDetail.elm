module Models.SpecDetail exposing (..)

import Dict
import Http
import Json.Decode as Decode exposing (field)


type alias SpecDetail =
    { filepath : String
    , name : String
    , method : String
    , endpoint : String
    , description : Maybe String
    , urlParams : Maybe (List String)
    , request : Request
    , response : Response
    }


type alias Request =
    { strict : Bool
    , contentType : String
    , headers : Maybe (Dict.Dict String String)
    , params : Maybe (List ParamChild)
    }


type alias Response =
    { strict : Bool
    , contentType : String
    , headers : Maybe (Dict.Dict String String)
    , data : Maybe (List ParamChild)
    }


type alias Param =
    { name : String
    , type_ : String
    , isArray : Bool
    , rules : List Rule
    , children : Maybe (List ParamChild)
    }


type ParamChild
    = ParamChild Param


type alias Rule =
    { name : String
    , param : String
    }



-- Method


hasUrlParams : SpecDetail -> Bool
hasUrlParams spec =
    case spec.urlParams of
        Just v ->
            List.isEmpty v |> not

        Nothing ->
            False



-- Messages


type Msg
    = OnFetchDetail (Result Http.Error SpecDetail)
    | FetchDetail String



-- Decoder


specDetailDecoder : Decode.Decoder SpecDetail
specDetailDecoder =
    Decode.map8 SpecDetail
        (field "filepath" Decode.string)
        (field "name" Decode.string)
        (field "method" Decode.string)
        (field "endpoint" Decode.string)
        (Decode.maybe <| field "description" Decode.string)
        (Decode.maybe <| field "urlParams" (Decode.list Decode.string))
        (field "request" requestDecoder)
        (field "response" responseDecoder)


requestDecoder : Decode.Decoder Request
requestDecoder =
    Decode.map4 Request
        (field "strict" Decode.bool)
        (field "contentType" Decode.string)
        (Decode.maybe <| field "headers" (Decode.dict Decode.string))
        (Decode.maybe <| field "params" (Decode.list paramChildDecoder))


responseDecoder : Decode.Decoder Response
responseDecoder =
    Decode.map4 Response
        (field "strict" Decode.bool)
        (field "contentType" Decode.string)
        (Decode.maybe <| field "headers" (Decode.dict Decode.string))
        (Decode.maybe <| field "data" (Decode.list paramChildDecoder))


paramChildDecoder : Decode.Decoder ParamChild
paramChildDecoder =
    Decode.map ParamChild (Decode.lazy (\_ -> paramDecoder))


paramDecoder : Decode.Decoder Param
paramDecoder =
    Decode.map5 Param
        (field "name" Decode.string)
        (field "type" Decode.string)
        (field "isArray" Decode.bool)
        (field "rules" (Decode.list ruleDecoder))
        (Decode.maybe <| field "children" (Decode.list paramChildDecoder))


ruleDecoder : Decode.Decoder Rule
ruleDecoder =
    Decode.map2 Rule
        (field "name" Decode.string)
        (field "param" Decode.string)
