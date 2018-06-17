module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import SpecListing.Update
import Sorting.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SpecListingMsg subMsg ->
            let
                ( updatedSpecs, cmd ) =
                    SpecListing.Update.update subMsg model.specs
            in
                ( { model | specs = updatedSpecs }, Cmd.map SpecListingMsg cmd )

        SortingMsg subMsg ->
            let
                ( updatedSorting, cmd ) =
                    Sorting.Update.update subMsg model.specSorting
            in
                ( { model | specSorting = updatedSorting }, Cmd.map SpecListingMsg cmd )
