module Models exposing (..)

import SpecListing.Models exposing (SpecListing)


type alias Model =
    { specs : List SpecListing
    }


initialModel : Model
initialModel =
    { specs = []
    }
