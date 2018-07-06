module Commands.Api exposing (..)

import Http
import SpecDetail.Models exposing (specDetailDecoder)
import SpecDetail.Messages
import SpecListing.Models exposing (specListingArrayDecoder)
import SpecList.Messages


fetchDetail : String -> Cmd SpecDetail.Messages.Msg
fetchDetail filepath =
    Http.get (url.fetchDetail ++ filepath) specDetailDecoder
        |> Http.send SpecDetail.Messages.OnFetchDetail


fetchAll : Cmd SpecList.Messages.Msg
fetchAll =
    Http.get url.fetchAll specListingArrayDecoder
        |> Http.send SpecList.Messages.OnFetchAll


url =
    { fetchDetail = "/api/specs"
    , fetchAll = "/api/specs"
    }
