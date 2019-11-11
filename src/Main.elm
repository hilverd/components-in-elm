module Main exposing (main)

import Browser
import Counter
import Html exposing (..)
import Html.Attributes exposing (..)



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = always Sub.none
        , view = view
        }



-- MODEL


type alias Model =
    { leftCounter : Counter.Model
    , rightCounter : Counter.Model
    }


initialModel : Model
initialModel =
    { leftCounter = Counter.initialModel "Left Counter"
    , rightCounter = Counter.initialModel "Right Counter"
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( initialModel, Cmd.none )



-- UPDATE


type Msg
    = LeftCounterMsg Counter.Msg
    | RightCounterMsg Counter.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LeftCounterMsg msg_ ->
            let
                ( leftCounterModel_, leftCounterCmd_ ) =
                    Counter.update msg_ model.leftCounter
            in
            ( { model | leftCounter = leftCounterModel_ }
            , Cmd.map LeftCounterMsg leftCounterCmd_
            )

        RightCounterMsg msg_ ->
            let
                ( rightCounterModel_, rightCounterCmd_ ) =
                    Counter.update msg_ model.rightCounter
            in
            ( { model | rightCounter = rightCounterModel_ }
            , Cmd.map RightCounterMsg rightCounterCmd_
            )



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ class "container" ]
        [ h1
            [ class "title" ]
            [ text "Components in Elm" ]
        , nav
            [ class "level" ]
            [ div
                [ class "level-item has-text-centered" ]
                [ div
                    []
                    [ Counter.view LeftCounterMsg model.leftCounter
                    ]
                ]
            , div
                [ class "level-item has-text-centered" ]
                [ div
                    []
                    [ Counter.view RightCounterMsg model.rightCounter
                    ]
                ]
            ]
        ]
