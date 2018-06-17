module Views.SpecListing exposing (listView)

import Html exposing (..)
import Html.Attributes exposing (class, attribute, title)
import SpecListing.Messages exposing (..)
import SpecListing.Models exposing (SpecListing)
import Sorting.Models exposing (Sorting, Direction(..))


listView : List SpecListing -> Sorting -> Html Msg
listView specs sorting =
    div [ class "specListing" ]
        [ h2 [ class "specListing-title" ] [ text "Specs" ]
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
    div [ class "specListing-header" ]
        [ text "sort"
        , sortButton sorting "name"
        , sortButton sorting "endpoint"
        , sortButton sorting "method"
        ]


sortButton : Sorting -> String -> Html Msg
sortButton sorting target =
    if sorting.field == target then
        button
            [ class ("acitve btn btn-primary btn-sm " ++ (sorting.direction |> toString |> String.toLower)) ]
            [ text target ]
    else
        button
            [ class "btn btn-outline-primary btn-sm"
            ]
            [ text target ]
