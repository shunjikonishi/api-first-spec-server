module Views.Layout exposing (..)

import Html exposing (Html, div, nav, text, a)
import Html.Attributes exposing (class, href)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Views.SpecListView exposing (listView)
import Views.SpecDetailView exposing (detailView)


layout : Model -> Html Msg
layout model =
    div [ class "container-fluid p-0 h-100" ]
        [ navbar model
        , mainRow model
        ]


navbar : Model -> Html Msg
navbar model =
    nav [ class "navbar navbar-dark fixed-top bg-dark" ]
        [ a [ class "navbar-bland", href "/" ] [ text "API-FIRST-SPEC" ] ]


mainRow : Model -> Html Msg
mainRow model =
    div [ class "workspace row" ]
        [ div [ class "col-4 left" ] [ left model ]
        , div [ class "col-8 right" ] [ right model ]
        ]


left : Model -> Html Msg
left model =
    listView model.specList


right : Model -> Html Msg
right model =
    case model.currentSpec of
        Just spec ->
            Html.map SpecDetailMsg (detailView spec)

        Nothing ->
            hello


hello : Html Msg
hello =
    div [] [ text "Hello api-sirst-spec" ]
