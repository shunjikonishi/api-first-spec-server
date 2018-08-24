module Views.SpecDetailView exposing (detailView)

import Html exposing (..)
import Html.Attributes exposing (class, colspan)
import Models.SpecDetail exposing (SpecDetail, Request, Response, Param, ParamChild(..), Msg(..))
import Dict


detailView : SpecDetail -> Html Msg
detailView spec =
    div []
        [ table [ class "table" ] [ tbodyBlock spec ]
        ]


tbodyBlock : SpecDetail -> Html Msg
tbodyBlock spec =
    tbody []
        ([ headerRow spec.filepath
         , normalRowWithVisible "name" spec.name (spec.name /= spec.endpoint)
         , normalRow "endpoint" (spec.method ++ " " ++ spec.endpoint)
         , normalRowWithVisible "urlParams" (Maybe.map toString spec.urlParams |> Maybe.withDefault "") (Models.SpecDetail.hasUrlParams spec)
         , normalRow "description" (Maybe.withDefault "" spec.description)
         ]
            ++ (requestBlock spec.request)
            ++ (responseBlock spec.response)
        )


tupleRow : ( String, String ) -> Html Msg
tupleRow ( key, value ) =
    normalRowWithVisible key value True


normalRow : String -> String -> Html Msg
normalRow key value =
    normalRowWithVisible key value True


normalRowWithVisible : String -> String -> Bool -> Html Msg
normalRowWithVisible key value visible =
    tr
        [ class
            (if visible then
                ""
             else
                "hidden"
            )
        ]
        [ th [ class "name-col" ] [ text key ], td [] [ text value ] ]


headerRow : String -> Html Msg
headerRow str =
    tr
        [ class "detail-header" ]
        [ th [ colspan 2 ] [ text str ] ]


requestBlock : Request -> List (Html Msg)
requestBlock request =
    [ headerRow "Request"
    , normalRow "Content-Type" request.contentType
    , headersRow request.headers
    , paramRow "params" request.params
    ]


responseBlock : Response -> List (Html Msg)
responseBlock response =
    [ headerRow "Response"
    , normalRow "Content-Type" response.contentType
    , headersRow response.headers
    , paramRow "data" response.data
    ]


headersRow : Maybe (Dict.Dict String String) -> Html Msg
headersRow headers =
    case headers of
        Just kv ->
            tr []
                [ th [] [ text "haeders" ]
                , td [] [ dictCell kv ]
                ]

        Nothing ->
            normalRowWithVisible "headers" "" False


dictCell : Dict.Dict String String -> Html Msg
dictCell dict =
    table [] [ tbody [] (List.map tupleRow (Dict.toList dict)) ]


paramRow : String -> Maybe (List ParamChild) -> Html Msg
paramRow name param =
    case param of
        Just list ->
            tr []
                [ th [ class "name-col" ] [ text name ]
                , td [] [ ul [] (List.map paramChildCell list) ]
                ]

        Nothing ->
            normalRowWithVisible name "" False


paramChildCell : ParamChild -> Html Msg
paramChildCell paramChild =
    case paramChild of
        ParamChild param ->
            paramCell param


paramCell : Param -> Html Msg
paramCell param =
    let
        value =
            if param.isArray then
                param.name ++ ": Array<" ++ param.type_ ++ ">"
            else
                param.name ++ ": " ++ param.type_

        items =
            case param.children of
                Just list ->
                    [ text value, ul [] (List.map paramChildCell list) ]

                Nothing ->
                    [ text value ]
    in
        li [] items
