module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Update.SpecList as SpecList
import Update.SpecDetail as SpecDetail


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SpecListMsg subMsg ->
            let
                ( updatedSpecList, cmd ) =
                    SpecList.update subMsg model.specList
            in
                ( { model | specList = updatedSpecList }, Cmd.map SpecListMsg cmd )

        SpecDetailMsg subMsg ->
            let
                ( updatedSpecDetail, cmd ) =
                    SpecDetail.update subMsg model.currentSpec
            in
                ( { model | currentSpec = updatedSpecDetail }, Cmd.map SpecDetailMsg cmd )
