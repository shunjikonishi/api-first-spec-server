module Models.SpecList exposing (..)

import Http
import Models.SpecListing exposing (SpecListing)


type alias SpecList =
    { filter : String
    , list : List SpecListing
    }


type Msg
    = OnFetchAll (Result Http.Error (List SpecListing))
    | OnFilter String
    | Reset
