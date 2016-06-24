port module Main exposing (..)

import Layout exposing (layout)
import Html exposing (..)
import Html.App
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Pages.Login as Login
import Navigation
import Router
import String
import Dict


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ loggedIn LoggedIn
        , Sub.map LoginMsg (Login.subscriptions model.login)
        ]


port loggedIn : (Bool -> msg) -> Sub msg


port logOut : () -> Cmd msg


urlUpdate urlInfo model =
    let
        ( routerModel, routerCmds ) =
            Router.urlUpdate urlInfo model.router
    in
        { model | router = routerModel } ! [ Cmd.map RouterMsg routerCmds ]



-- APP


main : Program Never
main =
    Navigation.program Router.urlParser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { loggedIn : Bool
    , router : Router.Model
    , login : Login.Model
    }


init routeInfo =
    let
        ( routerModel, routerCmds ) =
            Router.init routeInfo
    in
        { loggedIn = False
        , router = routerModel
        , login = Login.init
        }
            ! [ Cmd.map RouterMsg routerCmds
              ]



-- UPDATE


type Msg
    = NoOp
    | LoggedIn Bool
    | LogOut
    | LoginMsg Login.Msg
    | RouterMsg Router.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        LoggedIn val ->
            { model | loggedIn = val }
                ! [ if not val then
                        Navigation.modifyUrl <| "/#login?redirectTo=" ++ (String.join "/" model.router.location.path)
                    else
                        case String.join "" model.router.location.path of
                            "login" ->
                                Navigation.modifyUrl "/"

                            _ ->
                                case Dict.get "redirectTo" model.router.location.query of
                                    Just path ->
                                        let
                                            path' =
                                                case path of
                                                    "" ->
                                                        "/"

                                                    other ->
                                                        other
                                        in
                                            Navigation.modifyUrl (Debug.log "logged in, going to path" path')

                                    Nothing ->
                                        Cmd.none
                  ]

        LoginMsg msg' ->
            let
                ( m, c ) =
                    Login.update msg' model.login
            in
                { model | login = m } ! [ Cmd.map LoginMsg c ]

        LogOut ->
            model ! [ logOut () ]

        RouterMsg msg ->
            let
                ( rMdl, rCmd ) =
                    Router.update msg model.router
            in
                { model | router = rMdl } ! [ Cmd.map RouterMsg rCmd ]


view : Model -> Html Msg
view model =
    layout { onLogout = LogOut, model = model }
        <| case model.router.route of
            Router.MainRoute ->
                div []
                    [ text "WELCOME yEAAH"
                    , button [ class "button", onClick LogOut ] [ text "Log Out!" ]
                    , text <| toString model
                    ]

            Router.LoginRoute ->
                div []
                    [ Html.App.map LoginMsg <| Login.view model.login
                    ]

            Router.NotFoundRoute ->
                div [] [ text "404" ]
