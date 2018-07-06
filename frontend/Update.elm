module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import SpecList.Update
import SpecDetail.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SpecListMsg subMsg ->
            let
                ( updatedSpecList, cmd ) =
                    SpecList.Update.update subMsg model.specList
            in
                ( { model | specList = updatedSpecList }, Cmd.map SpecListMsg cmd )

        SpecDetailMsg subMsg ->
            let
                ( updatedSpecDetail, cmd ) =
                    SpecDetail.Update.update subMsg model.currentSpec
            in
                ( { model | currentSpec = updatedSpecDetail }, Cmd.map SpecDetailMsg cmd )
