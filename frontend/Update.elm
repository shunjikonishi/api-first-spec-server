module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import SpecList.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SpecListMsg subMsg ->
            let
                ( updatedSpecList, cmd ) =
                    SpecList.Update.update subMsg model.specList
            in
                ( { model | specList = updatedSpecList }, Cmd.map SpecListMsg cmd )
