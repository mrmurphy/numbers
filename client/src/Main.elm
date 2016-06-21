module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html
import Html.Events exposing (onClick)
import Material
import Material.Button as Button


-- component import example

import Components.Hello exposing (hello)


-- APP


main : Program Never
main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { count : Int
    , mdl : Material.Model
    }


model =
    { count = 0
    , mdl = Material.model
    }



-- UPDATE


type Msg
    = NoOp
    | Increment
    | Mdl Material.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        Increment ->
            { model | count = model.count + 1 }

        Mdl msg' ->
            let
                ( mdl, msg ) =
                    Material.update Mdl msg' model
            in
                mdl



-- VIEW
-- Html is defined as: elem [ attribs ][ children ]
-- CSS can be applied via class names or inline style attrib


view : Model -> Html Msg
view model =
    div [ class "container", style [ ( "margin-top", "30px" ), ( "text-align", "center" ) ] ]
        [ -- inline CSS (literal)
          div [ class "row" ]
            [ div [ class "col-xs-12" ]
                [ div [ class "jumbotron" ]
                    [ img [ src "img/elm.jpg", style styles.img ] []
                      -- inline CSS (via var)
                    , hello model.count
                      -- ext 'hello' component (takes 'model' as arg)
                    , p [] [ text ("Elm Webpack Starter") ]
                    , Button.render Mdl
                        [ 0 ]
                        model.mdl
                        [ Button.raised, Button.ripple, Button.onClick Increment ]
                        [ -- click handler
                          span [ class "glyphicon glyphicon-star" ] []
                          -- glyphicon
                        , span [] [ text "FTW!" ]
                        ]
                    , Button.render Mdl
                        [ 2 ]
                        model.mdl
                        [ Button.raised, Button.ripple, Button.onClick Increment ]
                        [ -- click handler
                          span [ class "glyphicon glyphicon-star" ] []
                          -- glyphicon
                        , span [] [ text "FTW!" ]
                        ]
                    ]
                ]
            ]
        ]



-- CSS STYLES


styles : { img : List ( String, String ) }
styles =
    { img =
        [ ( "width", "33%" )
        , ( "border", "4px solid #337AB7" )
        ]
    }
