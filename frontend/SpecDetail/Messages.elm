module SpecDetail.Messages exposing (..)

import Http
import SpecDetail.Models exposing (SpecDetail)


type Msg
    = OnFetchDetail (Result Http.Error SpecDetail)
    | FetchDetail String
