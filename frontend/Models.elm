module Models exposing (..)

import SpecList.Models exposing (SpecList)
import Sorting.Models exposing (Sorting, Direction(..))


type alias Model =
    { specList : SpecList
    }


initialModel : Model
initialModel =
    { specList =
        SpecList (Sorting "endpoint" Asc) []
    }
