module SpecListing.Models exposing (..)


type alias SpecListing =
    { filepath : String
    , endpoint : String
    , method : String
    , name : String
    , description : Maybe String
    }


dir : SpecListing -> String
dir spec =
    let
        list =
            String.split "/" spec.filepath
    in
        List.take (List.length list - 1) list |> String.join "/"


filename : SpecListing -> String
filename spec =
    let
        result =
            String.split "/" spec.filepath |> List.reverse |> List.head
    in
        case result of
            Just a ->
                a

            Nothing ->
                ""
