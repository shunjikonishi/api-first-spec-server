module SpecListing.Views.List exposing(view)

import Html exposing (..)
import Html.Attributes exposing (class)
import SpecListing.Messages exposing (..)
import SpecListing.Models exposing (SpecListing)

view: List SpecListing -> Html Msg
view specs =
  div []
      [ h2 [class "spec-listing-title"] [text "Specs"]
      , ul [] (List.map specItem specs)
      ]

specItem: SpecListing -> Html Msg
specItem spec =
  li []
     [text spec.method, text " ", text spec.endpoint]
