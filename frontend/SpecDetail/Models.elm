module SpecDetail.Models exposing (..)

import Dict


type alias SpecDetail =
    { filepath : String
    , name : String
    , method : String
    , endpoint : String
    , description : Maybe String
    , urlParams : List String
    , request : Request
    , response : Response
    }


type alias Request =
    { strict : Bool
    , contentType : String
    , headers : Dict.Dict String String
    , params : Dict.Dict String Param
    }


type alias Response =
    { strict : Bool
    , contentType : String
    , headers : Dict.Dict String String
    , data : Dict.Dict String Param
    }


type alias Param =
    { name : String
    , type_ : String
    , isArray : Bool
    , rules : List Rule
    , children : Dict.Dict String ParamChild
    }


type ParamChild
    = ParamChild Param


type alias Rule =
    { name : String
    , param : String
    }
