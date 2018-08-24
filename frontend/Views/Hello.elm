module Views.Hello exposing (hello)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class, href)
import Messages exposing (Msg(..))


hello : Html Msg
hello =
    div [ class "hello" ] [ text "Hello api-sirst-spec" ]
