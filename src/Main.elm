port module Showdron exposing (..)

import Html exposing (text, Html, div, button)
import Html.Attributes exposing (href)
import Html.Events exposing (onClick)


type alias Model =
    { currentDir : String
    , currentDirFiles : List String
    }


type Msg
    = NoOp
    | FetchDirList
    | DirListResponse (List String)
    | ClickOnFile String


init =
    ( { currentDir = "/"
      , currentDirFiles = []
      }
    , requestDirList "/"
    )


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


renderDirFiles : List String -> Html Msg
renderDirFiles files =
    let
        allFiles =
            ".." :: files
    in
        div
            []
        <|
            List.map (\file -> div [ onClick (ClickOnFile file) ] [ Html.a [ href "#" ] [text file] ]) allFiles


view : Model -> Html Msg
view model =
    div
        []
        [ renderDirFiles model.currentDirFiles
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchDirList ->
            model ! [ requestDirList model.currentDir ]

        DirListResponse files ->
            { model | currentDirFiles = files } ! []

        ClickOnFile file ->
            let
                newDir =
                    model.currentDir ++ file ++ "/"
            in
                { model | currentDir = newDir } ! [ requestDirList newDir ]

        NoOp ->
            model ! []


port requestDirList : String -> Cmd msg


port dirListResponse : (List String -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ dirListResponse DirListResponse ]
