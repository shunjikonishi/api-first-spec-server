module Messages exposing (..)

import Models.SpecList as SpecList
import Models.SpecDetail as SpecDetail


type Msg
    = SpecListMsg SpecList.Msg
    | SpecDetailMsg SpecDetail.Msg
