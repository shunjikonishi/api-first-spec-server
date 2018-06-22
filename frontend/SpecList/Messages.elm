module SpecList.Messages exposing (..)

import Http
import SpecListing.Models exposing (SpecListing)
import Sorting.Models exposing (Sorting)


type Msg
    = OnFetchAll (Result Http.Error (List SpecListing))
    | OnSort Sorting
