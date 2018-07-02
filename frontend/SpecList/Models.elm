module SpecList.Models exposing (SpecList)

import SpecListing.Models exposing (SpecListing)
import Sorting.Models exposing (Sorting)


type alias SpecList =
    { filter : String
    , list : List SpecListing
    }
