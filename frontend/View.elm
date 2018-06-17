module View exposing (..)

import Html exposing (Html, div, text)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Views.SpecListing exposing (listView)


view : Model -> Html Msg
view model =
    page model


page : Model -> Html Msg
page model =
    Html.map SpecListingMsg (listView model.specs model.specSorting)
