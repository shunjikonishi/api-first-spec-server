module View exposing (..)

import Html exposing (Html, div, text)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Views.Layout exposing (layout)


view : Model -> Html Msg
view model =
    layout model
