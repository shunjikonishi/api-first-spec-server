module SpecList.Views exposing (listView)

import Html exposing (..)
import Html.Attributes exposing (class, title)
import Html.Events exposing (onClick)
import SpecListing.Messages exposing (..)
import SpecListing.Models exposing (SpecListing)
import Sorting.Models exposing (Sorting, Direction(..))
import Sorting.Messages exposing (Msg(..))


listView : List SpecListing -> Sorting -> Html Sorting.Messages.Msg
listView specs sorting =
    div [ class "specListing" ]
        [ h2 [ class "specListing-title" ] [ text "Specs" ]
        , listHeader sorting
        , ul [] (List.map specItem specs)
        ]


specItem : SpecListing -> Html Sorting.Messages.Msg
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


listHeader : Sorting -> Html Sorting.Messages.Msg
listHeader sorting =
    div [ class "specListing-header" ]
        [ text "sort"
        , sortButton sorting "name"
        , sortButton sorting "endpoint"
        , sortButton sorting "method"
        ]


sortButton : Sorting -> String -> Html Sorting.Messages.Msg
sortButton sorting target =
    if sorting.field == target then
        button
            [ class ("acitve btn btn-primary btn-sm " ++ (sorting.direction |> toString |> String.toLower))
            , onClick
                (OnSpecListSort
                    (Sorting
                        target
                        (if sorting.direction == Asc then
                            Desc
                         else
                            Asc
                        )
                    )
                )
            ]
            [ text target ]
    else
        button
            [ class "btn btn-outline-primary btn-sm"
            , onClick (OnSpecListSort (Sorting target sorting.direction))
            ]
            [ text target ]
