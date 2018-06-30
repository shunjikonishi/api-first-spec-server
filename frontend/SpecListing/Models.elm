module SpecListing.Models exposing (..)


type alias SpecListing =
    { filepath : String
    , endpoint : String
    , method : String
    , name : String
    , description : Maybe String
    }
