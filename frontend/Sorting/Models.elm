module Sorting.Models exposing (..)


type Direction
    = Asc
    | Desc


type alias Sorting =
    { field : String
    , direction : Direction
    }
