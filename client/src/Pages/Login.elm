port module Pages.Login exposing (view, Model, Msg, update, subscriptions, init)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


port logIn : String -> Cmd msg


port loginError : (String -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ loginError LoginError
        ]


type alias Model =
    { password : String
    , loginError : Maybe String
    }


init =
    { password = ""
    , loginError = Nothing
    }


type Msg
    = LogIn String
    | LoginError String
    | UpdatePassword String


update msg model =
    case msg of
        LogIn pw ->
            model ! [ logIn pw ]

        UpdatePassword pw ->
            { model | password = pw } ! []

        LoginError str ->
            { model | loginError = Just str } ! []


content' model =
    div [ class "hero-body columns" ]
        [ div [ class "column has-text-centered is-8-mobile is-offset-2-mobile is-4 is-offset-4" ]
            [ h1 [ class "title" ]
                [ text "Login" ]
            , div [ class "has-text-left box" ]
                [ label [ class "label" ] [ text "Password" ]
                , input [ class "input control", type' "password", onInput UpdatePassword ] []
                , button [ class "button is-primary is-success is-fullwidth", onClick (LogIn model.password) ] [ text "Go!" ]
                ]
            , case model.loginError of
                Just msg ->
                    div [ class "notification is-danger" ]
                        [ text msg ]

                Nothing ->
                    div [] []
            ]
        ]


view model =
    section [ class "hero is-primary is-fullheight page-login" ]
        [ content' model ]
