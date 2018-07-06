module SpecList.Messages exposing (..)

import Http
import SpecListing.Models exposing (SpecListing)


type Msg
    = OnFetchAll (Result Http.Error (List SpecListing))
    | OnFilter String
