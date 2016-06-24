module Layout exposing (layout)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


header' props =
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
                    [ case props.model.loggedIn of
                        False ->
                            a [ class "nav-item is-active" ]
                                [ text "Login" ]

                        True ->
                            a [ class "nav-item", onClick props.onLogout ] [ text "Log Out" ]
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


layout props children =
    div []
        [ header' props
        , children
        , footer'
        ]
