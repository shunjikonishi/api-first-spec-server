module Views.SpecDetailView exposing (detailView)

import Html exposing (..)
import Html.Attributes exposing (class)
import SpecDetail.Models exposing (SpecDetail)
import SpecDetail.Messages exposing (Msg(..))


detailView : SpecDetail -> Html Msg
detailView spec =
    div []
        [ div [] [ text spec.name ]
        , div [] [ text spec.filepath ]
        ]
