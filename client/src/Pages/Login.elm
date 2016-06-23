module Pages.Login exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


header' =
    div [ class "hero-head" ]
        [ header [ class "nav" ]
            [ div [ class "container" ]
                [ div [ class "nav-left" ]
                    [ a [ class "nav-item" ]
                        [ img [ src "img/logo.png", alt "Logo" ]
                            []
                        ]
                    ]
                , span [ class "nav-toggle" ]
                    [ span []
                        []
                    , span []
                        []
                    , span []
                        []
                    ]
                , div [ class "nav-right nav-menu" ]
                    [ a [ class "nav-item is-active" ]
                        [ text "Login" ]
                    , a [ class "nav-item" ]
                        [ text "Roll" ]
                    , a [ class "nav-item" ]
                        [ text "Districts" ]
                    , a [ class "nav-item" ]
                        [ text "Reports" ]
                    ]
                ]
            ]
        ]


content' props =
    div [ class "hero-body columns" ]
        [ div [ class "column has-text-centered is-8-mobile is-offset-2-mobile is-4 is-offset-4" ]
            [ h1 [ class "title" ]
                [ text "Login" ]
            , div [ class "has-text-left box" ]
                [ label [ class "label" ] [ text "Password" ]
                , input [ class "input control", type' "password", onInput props.onUpdate ] []
                , button [ class "button is-primary is-success is-fullwidth", onClick props.onSubmit ] [ text "Go!" ]
                ]
            , case props.model.loginError of
                Just msg ->
                    div [ class "notification is-danger" ]
                        [ text msg ]

                Nothing ->
                    div [] []
            ]
        ]


footer' =
    div [ class "hero-foot" ]
        [ nav [ class "is-fullwidth has-text-centered" ]
            [ div [ class "container" ]
                [ span [ class "content" ]
                    [ text "From your friends at Honey Butter Breakfast"
                    ]
                ]
            ]
        ]


view props =
    section [ class "hero is-primary is-fullheight page-login" ]
        [ header'
        , content' props
        , footer'
        , text <| toString props.model
        ]
