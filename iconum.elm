import Html exposing (Html, button, div, text)
import Html.App as Html
import Html.Events exposing (onClick)
import Svg exposing (svg, circle, path)
import Svg.Attributes exposing (width, height, viewBox, r, fill, stroke, strokeWidth, cx, cy, d)


main =
  Html.beginnerProgram
    { model = globalModel
      , view = view
      , update = update
    }


-- MODEL

type alias Model = Int

globalModel : Model
globalModel = 0


-- UPDATE

type Msg = Reset | Inc | Dec


update : Msg -> Model -> Model
update msg model =
  case msg of
    Inc ->
      model + 1
    Dec ->
      model - 1
    Reset ->
      0


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Dec ] [ text "-" ]
    , div [] [ text (toString model) ]
    , svg [ width "400", height "400", viewBox "0 0 100 100" ]
        (numeral model)
    , button [ onClick Inc ] [ text "+"]]

numeral x =
  let
    dphi = 2.0 * pi / (toFloat x)
    phis = List.map (\i -> (toFloat i) * dphi) [1..x]
    points = List.map (\phi -> (toString ((cos phi) * 20.0 + 50.0))
                           ++ " "
                           ++ (toString ((sin phi) * 20.0 + 50.0))) phis
    p = "M " ++ (List.foldr (++) "" (List.intersperse " L " points)) ++ " z"
  in
    if x == 0 then
      [ circle [ fill "none", stroke "black", r "20", cx "50", cy "50" ] []]
    else if x == 1 then
      [ path [ stroke "black", d "M 50 30, L 50 70"] []]
    else
      [ path [ fill "green", strokeWidth "5", stroke "black", d p] []]
