port module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App
import Pages.Login as Login


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ loggedIn LoggedIn
        , loginError LoginError
        ]


port logIn : String -> Cmd msg


port loggedIn : (Bool -> msg) -> Sub msg


port loginError : (String -> msg) -> Sub msg



-- APP


main : Program Never
main =
    Html.App.program
        { init = model ! []
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { loggedIn : Bool
    , password : String
    , loginError : Maybe String
    }


model =
    { loggedIn = False
    , password = ""
    , loginError = Nothing
    }



-- UPDATE


type Msg
    = NoOp
    | LoggedIn Bool
    | UpdatePassword String
    | LogIn String
    | LoginError String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        LoggedIn val ->
            { model | loggedIn = val } ! []

        LogIn pw ->
            model ! [ logIn pw ]

        UpdatePassword pw ->
            { model | password = pw } ! []

        LoginError str ->
            { model | loginError = Just str } ! []


view : Model -> Html Msg
view model =
    div []
        [ Login.view { model = model, onSubmit = LogIn model.password, onUpdate = UpdatePassword }
        ]
