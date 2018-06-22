module View exposing (..)

import Html exposing (Html, div, text)
import Messages exposing (Msg(..))
import Models exposing (Model)
import SpecList.Views exposing (listView)


view : Model -> Html Msg
view model =
    page model


page : Model -> Html Msg
page model =
    Html.map SpecListMsg (listView model.specList)
