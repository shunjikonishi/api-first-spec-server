module SpecList.Views exposing (listView)

import Html exposing (..)
import Html.Attributes exposing (class, title)
import Html.Events exposing (onClick)
import SpecList.Messages exposing (Msg(..))
import SpecList.Models exposing (SpecList)
import SpecListing.Models exposing (SpecListing)
import Sorting.Models exposing (Sorting, Direction(..))


listView : SpecList -> Html Msg
listView specList =
    div [ class "specList" ]
        [ h2 [ class "specList-title" ] [ text "Specs" ]
        , listHeader specList.sorting
        , ul [] (List.map specItem specList.list)
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
            [ class ("acitve btn btn-primary btn-sm " ++ (sorting.direction |> toString |> String.toLower))
            , onClick
                (OnSort
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
            , onClick (OnSort (Sorting target sorting.direction))
            ]
            [ text target ]
