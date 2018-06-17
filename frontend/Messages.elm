module Messages exposing (..)

import SpecListing.Messages
import Sorting.Messages


type Msg
    = SpecListingMsg SpecListing.Messages.Msg
    | SortingMsg Sorting.Messages.Msg
