module Models exposing (..)

import SpecList.Models exposing (SpecList)
import SpecDetail.Models exposing (SpecDetail)


type alias Model =
    { specList : SpecList
    , currentSpec : Maybe SpecDetail
    }


initialModel : Model
initialModel =
    { specList = SpecList "" []
    , currentSpec = Nothing
    }
