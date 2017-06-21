port module Showdron exposing (..)

import Html exposing (text, Html, div, button)
import Html.Events exposing (onClick)


type alias Model =
    {}


type Msg
    = NoOp


init =
    ( {}
    , Cmd.none
    )


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


view : Model -> Html Msg
view model =
    div
        []
        [ text "Hello world!" ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        []
