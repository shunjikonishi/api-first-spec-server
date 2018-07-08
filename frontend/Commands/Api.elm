module Commands.Api exposing (..)

import Http
import Models.SpecDetail as SpecDetail exposing (specDetailDecoder)
import Models.SpecList as SpecList
import Models.SpecListing exposing (specListingArrayDecoder)


fetchDetail : String -> Cmd SpecDetail.Msg
fetchDetail filepath =
    Http.get (url.fetchDetail ++ filepath) specDetailDecoder
        |> Http.send SpecDetail.OnFetchDetail


fetchAll : Cmd SpecList.Msg
fetchAll =
    Http.get url.fetchAll specListingArrayDecoder
        |> Http.send SpecList.OnFetchAll


reset : Cmd SpecList.Msg
reset =
    Http.post url.resetSpecs Http.emptyBody specListingArrayDecoder
        |> Http.send SpecList.OnFetchAll


url =
    { fetchDetail = "/api/specs"
    , fetchAll = "/api/specs"
    , resetSpecs = "/api/reset"
    }
