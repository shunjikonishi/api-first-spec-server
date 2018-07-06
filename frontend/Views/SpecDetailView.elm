module Views.SpecDetailView exposing (detailView)

import Html exposing (..)
import Html.Attributes exposing (class)
import Models.SpecDetail exposing (SpecDetail, Msg(..))


detailView : SpecDetail -> Html Msg
detailView spec =
    div []
        [ div [] [ text spec.name ]
        , div [] [ text spec.filepath ]
        ]
