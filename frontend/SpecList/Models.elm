module SpecList.Models exposing (SpecList)

import SpecListing.Models exposing (SpecListing)


type alias SpecList =
    { filter : String
    , list : List SpecListing
    }
