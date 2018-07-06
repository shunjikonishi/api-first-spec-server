module Views.SpecList exposing (listView)

import Html exposing (..)
import Html.Attributes exposing (class, title, href, type_, placeholder, value)
import Html.Attributes.Aria exposing (ariaHidden)
import Html.Events exposing (onInput)
import Html.Events.Extra exposing (onClickPreventDefault)
import Messages exposing (Msg(..))
import SpecList.Messages
import SpecDetail.Messages
import SpecList.Models exposing (SpecList)
import SpecListing.Models exposing (..)
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
            [ Html.map SpecListMsg (listHeader specList.filter)
            , Html.map SpecDetailMsg (dirList dirs specs)
            ]


listHeader : String -> Html SpecList.Messages.Msg
listHeader filter =
    div [ class "specList-header" ]
        [ searchInput filter
        ]


searchInput : String -> Html SpecList.Messages.Msg
searchInput str =
    div
        [ class "search" ]
        [ i [ class "oi oi-magnifying-glass" ] []
        , input [ type_ "text", class "form-control", placeholder "Search", value str, onInput SpecList.Messages.OnFilter ] []
        ]


dirList : List String -> List SpecListing -> Html SpecDetail.Messages.Msg
dirList dirs specs =
    ul [ class "specList-dir-list" ]
        (List.map
            (dirItem specs)
            dirs
        )


dirItem : List SpecListing -> String -> Html SpecDetail.Messages.Msg
dirItem specs dirname =
    li [ class "specList-dir" ]
        [ span [] [ text dirname ]
        , ul [ class "specList-item-list" ] (List.filter (\x -> (dir x) == dirname) specs |> List.map specItem)
        ]


specItem : SpecListing -> Html SpecDetail.Messages.Msg
specItem spec =
    li
        [ class "specList-item" ]
        [ a
            [ href "#", onClickPreventDefault (SpecDetail.Messages.FetchDetail spec.filepath) ]
            [ text (filename spec |> String.split "." |> List.head |> Maybe.withDefault (filename spec)) ]
        ]
