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
    , urlParams : List String
    , request : Maybe Request
    , response : Maybe Response
    }


type alias Request =
    { strict : Bool
    , contentType : String
    , headers : Maybe (Dict.Dict String String)
    , params : Maybe (Dict.Dict String Param)
    }


type alias Response =
    { strict : Bool
    , contentType : String
    , headers : Maybe (Dict.Dict String String)
    , data : Maybe (Dict.Dict String Param)
    }


type alias Param =
    { name : String
    , type_ : String
    , isArray : Bool
    , rules : List Rule
    , children : Dict.Dict String ParamChild
    }


type ParamChild
    = ParamChild Param


type alias Rule =
    { name : String
    , param : String
    }



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
