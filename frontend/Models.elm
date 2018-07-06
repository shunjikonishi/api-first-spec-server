module Models exposing (..)

import Models.SpecList exposing (SpecList)
import Models.SpecDetail exposing (SpecDetail)


type alias Model =
    { specList : SpecList
    , currentSpec : Maybe SpecDetail
    }


initialModel : Model
initialModel =
    { specList = SpecList "" []
    , currentSpec = Nothing
    }
