module SpecListing.Views.List exposing(view)

import Html exposing (..)
import Html.Attributes exposing (class, attribute, title)
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
  let
     attributes = case spec.description of
       Just v -> [title v]
       Nothing -> []
  in
    li 
      attributes
      [ text (spec.name ++ "(" ++ spec.method ++ ")")]
