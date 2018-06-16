module SpecListing.Models exposing (..)


type alias SpecListing =
    { endpoint : String
    , method : String
    , name : String
    , description : Maybe String
    }
