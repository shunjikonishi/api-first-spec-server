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


filter : String -> SpecListing -> Bool
filter str spec =
    let
        lower =
            String.toLower str

        len =
            String.length str
    in
        len
            == 0
            || String.contains lower (String.toLower spec.method)
            || String.contains lower (String.toLower spec.endpoint)
            || String.contains lower (String.toLower spec.filepath)
