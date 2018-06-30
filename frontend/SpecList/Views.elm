module SpecList.Views exposing (listView)

import Html exposing (..)
import Html.Attributes exposing (class, title, href)
import Html.Events.Extra exposing (onClickPreventDefault)
import SpecList.Messages exposing (Msg(..))
import SpecList.Models exposing (SpecList)
import SpecListing.Models exposing (..)
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
            [ text (spec.name ++ "(" ++ spec.method ++ ")" ++ (filename spec) ++ "---" ++ (dir spec)) ]


listHeader : Sorting -> Html Msg
listHeader sorting =
    div [ class "specList-header" ]
        [ text "sort"
        , sortButton sorting "name"
        , sortButton sorting "endpoint"
        , sortButton sorting "method"
        ]


sortButton : Sorting -> String -> Html Msg
sortButton sorting target =
    if sorting.field == target then
        a
            [ class ("badge badge-primary " ++ (sorting.direction |> toString |> String.toLower))
            , href "#"
            , onClickPreventDefault
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
        a
            [ class "badge badge-secondary"
            , href "#"
            , onClickPreventDefault (OnSort (Sorting target sorting.direction))
            ]
            [ text target ]
