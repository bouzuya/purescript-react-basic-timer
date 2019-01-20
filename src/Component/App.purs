module Component.App
  ( app
  ) where

import Prelude

import Data.DateTime (DateTime)
import Data.DateTime as DateTime
import Data.Int as Int
import Data.Maybe (Maybe(..), fromMaybe, maybe)
import Data.Newtype (unwrap, wrap)
import Data.Time.Duration (Seconds)
import Effect (Effect)
import Effect.Now (nowDateTime)
import Effect.Timer (setTimeout)
import Math as Math
import React.Basic (Component, JSX, Self, StateUpdate(..), capture, capture_, createComponent, make, send)
import React.Basic.DOM as H
import React.Basic.DOM.Events (targetValue)

type Props =
  {}

type State =
  { duration :: Seconds
  , startedAt :: Maybe DateTime
  , value :: Number
  }

data Action
  = Reset
  | Start
  | Tick DateTime
  | UpdateDuration String
  | UpdateStartedAt DateTime

component :: Component Props
component = createComponent "App"

app :: JSX
app = make component { didMount, initialState, render, update } {}

didMount :: Self Props State Action -> Effect Unit
didMount self = send self Start

initialState :: State
initialState =
  { duration: wrap 30.0
  , startedAt: Nothing
  , value: 0.0
  }

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
            [ H.text (show (fromMaybe 0 (Int.fromNumber (Math.round self.state.value))))
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
              , value: show (unwrap self.state.duration)
              }
            ]
          }
        , H.div
          { children:
            [ H.button
              { onClick: capture_ self Reset
              , children: [ H.text "Reset"]
              }
            ]
          }
        ]
      }
    , H.div
      { className: "footer" }
    ]
  }

update :: Self Props State Action -> Action -> StateUpdate Props State Action
update self Reset = do
  UpdateAndSideEffects
    (self.state { value = 0.0 })
    (\self' -> do
      dt <- nowDateTime
      send self (UpdateStartedAt dt))
update self Start = do
  SideEffects
    (\self' -> do
      dt <- nowDateTime
      send self (UpdateStartedAt dt)
      send self (Tick dt))
update self (Tick dt) =
  UpdateAndSideEffects
    (self.state
      { value =
          maybe
            0.0
            (\at -> unwrap ((DateTime.diff dt at) :: Seconds))
            self.state.startedAt
      })
    (\self' ->
      void (setTimeout 1000 (nowDateTime >>= \dt' -> (send self' (Tick dt')))))
update self (UpdateDuration s) =
  case Int.fromString s of
    Nothing -> NoUpdate
    Just n -> Update self.state { duration = wrap (Int.toNumber n) }
update self (UpdateStartedAt dt) =
  Update self.state { startedAt = Just dt }
