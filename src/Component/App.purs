module Component.App
  ( app
  ) where

import Prelude

import Data.Int as Int
import Data.Maybe (Maybe(..), fromMaybe)
import React.Basic (Component, JSX, Self, StateUpdate(..), capture, createComponent, make)
import React.Basic.DOM as H
import React.Basic.DOM.Events (targetValue)

type Props =
  {}

type State =
  { duration :: Int }

data Action
  = UpdateDuration String

component :: Component Props
component = createComponent "App"

app :: JSX
app = make component { initialState, render, update } {}

initialState :: State
initialState =
  { duration: 30 }

render :: Self Props State Action -> JSX
render self =
  H.div
  { className: "app"
  , children:
    [ H.div
      { className: "header"
      , children:
        [ H.h1_
          [ H.text "App" ]
        ]
      }
    , H.div
      { className: "body"
      , children:
        [ H.div
          { children:
            [ H.span_ [ H.text "Elapsed Time"]
            , H.progress { max: 100.0, value: "0" }
            ]
          }
        , H.div
          { children:
            [ H.text "0"
            , H.text "s"
            ]
          }
        , H.div
          { children:
            [ H.span_ [ H.text "Duration" ]
            , H.input
              { min: 0.0
              , max: 3600.0
              , onChange:
                  capture
                    self
                    targetValue
                    (\v -> UpdateDuration (fromMaybe "" v))
              , type: "range"
              , value: show self.state.duration
              }
            ]
          }
        , H.div
          { children:
            [ H.button_ [ H.text "Reset"]
            ]
          }
        ]
      }
    , H.div
      { className: "footer" }
    ]
  }

update :: Self Props State Action -> Action -> StateUpdate Props State Action
update self (UpdateDuration s) =
  case Int.fromString s of
    Nothing -> NoUpdate
    Just n -> Update self.state { duration = n }
