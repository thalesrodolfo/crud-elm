import Html exposing (..)
import Html.Events exposing (onClick)
import StartApp.Simple as StartApp

-- Model
type alias Material =
  { nome : String
  , valor: Float
  }


type alias Model =
  List Material


init = [{nome="Telha", valor=1.30}
       ,{nome="Porcelana", valor=3.90}
       ]


type Action
  = Adicionar
  | Remover


-- Update
update : Action -> Model -> Model
update action model =
  case action of
    Adicionar ->
      let
        novoMaterial = [{nome="novoMaterial", valor=0.00}]
      in
        List.append model novoMaterial

    Remover -> model


-- View
trowItem : String -> Float -> Html
trowItem nome valor = tr [] [ td [] [text nome]
                            , td [] [text (toString valor)]
                            ]


tableBody : Model -> Html
tableBody lista =
  tbody [] (List.map (\x -> trowItem x.nome x.valor) lista)

        
view : Signal.Address Action -> Model -> Html
view address listaMateriais = div [] [table [] [
                              thead [] [ tr [] [ th [] [text "Material"]
                                               , th [] [text "Valor"]
                                               ]
                                       , tableBody listaMateriais
                                       ]
                             ]
                     , button [onClick address Adicionar ] [text "Adicionar"]
                    ]

             
main =
  StartApp.start
            { model = init
            , view = view
            , update = update
            }
