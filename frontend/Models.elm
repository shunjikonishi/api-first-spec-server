module Models exposing (..)

import SpecListing.Models exposing (SpecListing)
import Sorting.Models exposing (Sorting, Direction(..))


type alias Model =
    { specs : List SpecListing
    , specSorting : Sorting
    }


initialModel : Model
initialModel =
    { specs = []
    , specSorting = Sorting "endpoint" Asc
    }
