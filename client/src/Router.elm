module Router exposing (init, update, urlUpdate, urlParser, Model, Msg, Route(..))

-- Most of this is copied directly from
-- https://github.com/sporto/hop/blob/master/examples/basic/Main.elm

import Hop exposing (makeUrl, makeUrlFromLocation, matchUrl, setQuery)
import Hop.Matchers exposing (..)
import Hop.Types exposing (Config, Query, Location, PathMatcher, Router)
import Navigation


type Route
    = LoginRoute
    | MainRoute
    | NotFoundRoute


type Msg
    = NavigateTo String
    | SetQuery Query


type alias Model =
    { location : Location
    , route : Route
    }


matchers : List (PathMatcher Route)
matchers =
    [ match1 MainRoute ""
    , match1 LoginRoute "/login"
    ]


routerConfig : Config Route
routerConfig =
    { hash = True
    , basePath = ""
    , matchers = matchers
    , notFound = NotFoundRoute
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case (Debug.log "route msg" msg) of
        NavigateTo path ->
            let
                command =
                    makeUrl routerConfig path
                        |> Navigation.modifyUrl
            in
                ( model, command )

        SetQuery query ->
            let
                command =
                    model.location
                        |> setQuery query
                        |> makeUrlFromLocation routerConfig
                        |> Navigation.modifyUrl
            in
                ( model, command )


{-|
Create a URL Parser for Navigation
Here we take `.href` from `Navigation.location` and send this to `Hop.matchUrl`.
`matchUrl` returns a tuple: (matched route, Hop location record). e.g.
    (User 1, { path = ["users", "1"], query = Dict.empty })
-}
urlParser : Navigation.Parser ( Route, Hop.Types.Location )
urlParser =
    Navigation.makeParser (.href >> matchUrl routerConfig)


{-|
Navigation will call urlUpdate when the location changes.
This function gets the result from `urlParser`, which is a tuple with (Route, Hop.Types.Location)
Location is a record that has:
```elm
{
  path: List String,
  query: Hop.Types.Query
}
```
- `path` is an array of string that has the current path e.g. `["users", "1"]` for `"/users/1"`
- `query` Is dictionary of String String. You can access this information in your views to show the content.
Store these two things in the model. We store location because it is needed for matching a query string.
-}
urlUpdate : ( Route, Hop.Types.Location ) -> Model -> ( Model, Cmd Msg )
urlUpdate ( route, location ) model =
    ( { model | route = route, location = location }, Cmd.none )


{-|
Your init function will receive an initial payload from Navigation, this payload is the initial matched location.
Here we store the `route` and `location` in our model.
-}
init : ( Route, Hop.Types.Location ) -> ( Model, Cmd Msg )
init ( route, location ) =
    ( Model location route, Cmd.none )
