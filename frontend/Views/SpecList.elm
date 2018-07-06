module Views.SpecList exposing (listView)

import Html exposing (..)
import Html.Attributes exposing (class, title, href, type_, placeholder, value)
import Html.Attributes.Aria exposing (ariaHidden)
import Html.Events exposing (onInput)
import Html.Events.Extra exposing (onClickPreventDefault)
import Messages exposing (Msg(..))
import Models.SpecList exposing (SpecList)
import Models.SpecListing exposing (..)
import Models.SpecDetail
import List.Extra


listView : SpecList -> Html Msg
listView specList =
    let
        specs =
            List.filter (filter specList.filter) specList.list

        dirs =
            List.map dir specs |> List.Extra.unique
    in
        div [ class "specList" ]
            [ listHeader specList.filter
            , dirList dirs specs
            ]


listHeader : String -> Html Msg
listHeader filter =
    div [ class "specList-header" ]
        [ Html.map SpecListMsg (searchInput filter)
        ]


searchInput : String -> Html Models.SpecList.Msg
searchInput str =
    div
        [ class "search" ]
        [ i [ class "oi oi-magnifying-glass" ] []
        , input [ type_ "text", class "form-control", placeholder "Search", value str, onInput Models.SpecList.OnFilter ] []
        ]


dirList : List String -> List SpecListing -> Html Msg
dirList dirs specs =
    ul [ class "specList-dir-list" ]
        (List.map
            (dirItem specs)
            dirs
        )


dirItem : List SpecListing -> String -> Html Msg
dirItem specs dirname =
    li [ class "specList-dir" ]
        [ span [] [ text dirname ]
        , ul [ class "specList-item-list" ] (List.filter (\x -> (dir x) == dirname) specs |> List.map specItem)
        ]


specItem : SpecListing -> Html Msg
specItem spec =
    li
        [ class "specList-item" ]
        [ a
            [ href "#", onClickPreventDefault (SpecDetailMsg (Models.SpecDetail.FetchDetail spec.filepath)) ]
            [ text (filename spec |> String.split "." |> List.head |> Maybe.withDefault (filename spec)) ]
        ]
