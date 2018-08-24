module Views.Layout exposing (..)

import Html exposing (Html, div, nav, text, a, button)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Views.SpecListView exposing (listView)
import Views.SpecDetailView exposing (detailView)
import Views.Hello exposing (hello)
import Models.SpecList as SpecList


layout : Model -> Html Msg
layout model =
    div [ class "container-fluid p-0 h-100" ]
        [ Html.map SpecListMsg (navbar model)
        , mainRow model
        ]


navbar : Model -> Html SpecList.Msg
navbar model =
    nav [ class "navbar navbar-dark fixed-top bg-dark" ]
        [ a [ class "navbar-bland", href "/" ] [ text "API-FIRST-SPEC" ]
        , button [ class "btn btn-success btn-sm", onClick SpecList.Reset ] [ text "Reset" ]
        ]


mainRow : Model -> Html Msg
mainRow model =
    div [ class "workspace row" ]
        [ div [ class "col-3 left" ] [ left model ]
        , div [ class "col-9 right" ] [ right model ]
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
