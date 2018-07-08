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
    , param : RuleParam
    }


type RuleParam
    = IntRuleParam Int
    | StringRuleParam String
    | BoolRuleParam Bool



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
    field "name" Decode.string
        |> Decode.andThen ruleParamDecoder


ruleParamDecoder : String -> Decode.Decoder Rule
ruleParamDecoder name =
    case name of
        "required" ->
            boolRuleDecoder

        "requiredAllowEmptyString" ->
            boolRuleDecoder

        "email" ->
            boolRuleDecoder

        "url" ->
            boolRuleDecoder

        "min" ->
            intRuleDecoder

        "max" ->
            intRuleDecoder

        "minlength" ->
            intRuleDecoder

        "maxllength" ->
            intRuleDecoder

        "pattern" ->
            stringRuleDecoder

        _ ->
            stringRuleDecoder


boolRuleDecoder : Decode.Decoder Rule
boolRuleDecoder =
    Decode.map2 Rule
        (field "name" Decode.string)
        (Decode.map BoolRuleParam (field "param" Decode.bool))


intRuleDecoder : Decode.Decoder Rule
intRuleDecoder =
    Decode.map2 Rule
        (field "name" Decode.string)
        (Decode.map IntRuleParam (field "param" Decode.int))


stringRuleDecoder : Decode.Decoder Rule
stringRuleDecoder =
    Decode.map2 Rule
        (field "name" Decode.string)
        (Decode.map StringRuleParam (field "param" Decode.string))
