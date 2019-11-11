module Counter exposing (Model, Msg, initialModel, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)



-- MODEL


type alias Model =
    { title : String
    , counter : Int
    }


initialModel : String -> Model
initialModel title =
    { title = title
    , counter = 0
    }



-- UPDATE


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( model |> updateCounter ((+) 1), Cmd.none )

        Decrement ->
            ( model |> updateCounter ((+) -1), Cmd.none )


updateCounter : (Int -> Int) -> { a | counter : Int } -> { a | counter : Int }
updateCounter f r =
    { r | counter = f r.counter }



-- VIEW


view : (Msg -> parentMsg) -> Model -> Html parentMsg
view msgWrapper model =
    div
        []
        [ p
            [ class "heading" ]
            [ text model.title ]
        , p
            [ class "title" ]
            [ button
                [ class "button"
                , style "margin-right" "1ex"
                , onClick <| msgWrapper Decrement
                ]
                [ text "-" ]
            , text <| String.fromInt model.counter
            , button
                [ class "button"
                , style "margin-left" "1ex"
                , onClick <| msgWrapper Increment
                ]
                [ text "+" ]
            ]
        ]
