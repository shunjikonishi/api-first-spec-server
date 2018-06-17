module SpecListing.View exposing (listView)

import Html exposing (..)
import Html.Attributes exposing (class, attribute, title)
import SpecListing.Messages exposing (..)
import SpecListing.Models exposing (SpecListing)
import Sorting.Models exposing (Sorting, Direction(..))


listView : List SpecListing -> Sorting -> Html Msg
listView specs sorting =
    div []
        [ h2 [ class "spec-listing-title" ] [ text "Specs" ]
        , listHeader sorting
        , ul [] (List.map specItem specs)
        ]


specItem : SpecListing -> Html Msg
specItem spec =
    let
        attributes =
            case spec.description of
                Just v ->
                    [ title v ]

                Nothing ->
                    []
    in
        li
            attributes
            [ text (spec.name ++ "(" ++ spec.method ++ ")") ]


listHeader : Sorting -> Html Msg
listHeader sorting =
    div []
        [ text "sort"
        , sortButton sorting "name"
        , sortButton sorting "endpoint"
        , sortButton sorting "method"
        ]


sortButton : Sorting -> String -> Html Msg
sortButton sorting target =
    let
        directionMark =
            case sorting.direction of
                Asc ->
                    "🔻"

                Desc ->
                    "🔺"
    in
        if sorting.field == target then
            button
                [ class "acitve btn btn-primary"
                ]
                [ text (target ++ " " ++ directionMark) ]
        else
            button
                [ class "btn btn-primary"
                ]
                [ text target ]
