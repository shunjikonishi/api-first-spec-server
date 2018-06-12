module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import SpecListing.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    SpecListingMsg subMsg ->
      let
        ( updatedSpecs, cmd ) = SpecListing.Update.update subMsg model.specs
      in 
        ( { model | specs = updatedSpecs }, Cmd.map SpecListingMsg cmd )