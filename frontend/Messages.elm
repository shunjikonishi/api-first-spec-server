module Messages exposing (..)

import SpecList.Messages
import SpecDetail.Messages


type Msg
    = SpecListMsg SpecList.Messages.Msg
    | SpecDetailMsg SpecDetail.Messages.Msg
