module Counter exposing (Model, Msg, initialModel, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events as Events



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


update :
    (Model -> parentModel)
    -> (Msg -> parentMsg)
    -> Msg
    -> Model
    -> ( parentModel, Cmd parentMsg )
update updateParentModel toParentCmd msg model =
    let
        ( model_, cmd ) =
            case msg of
                Increment ->
                    ( model |> mapCounter ((+) 1), Cmd.none )

                Decrement ->
                    ( model |> mapCounter ((+) -1), Cmd.none )
    in
    ( updateParentModel model_, Cmd.map toParentCmd cmd )


mapCounter : (Int -> Int) -> { a | counter : Int } -> { a | counter : Int }
mapCounter f r =
    { r | counter = f r.counter }



-- VIEW


view : (Msg -> parentMsg) -> Model -> Html parentMsg
view toParentMsg model =
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
                , Events.onClick <| toParentMsg Decrement
                ]
                [ text "-" ]
            , text <| String.fromInt model.counter
            , button
                [ class "button"
                , style "margin-left" "1ex"
                , Events.onClick <| toParentMsg Increment
                ]
                [ text "+" ]
            ]
        ]
