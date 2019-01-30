module Component.App
  ( app
  ) where

import Component.AppStyle as Style
import Component.Form as Form
import Data.Foldable (intercalate)
import PureStyle (getStyle)
import React.Basic (Component, JSX, Self, StateUpdate(..), createComponent, make)
import React.Basic.DOM as H

type Props =
  {}

type State =
  {}

data Action
  = Noop

component :: Component Props
component = createComponent "App"

app :: JSX
app = make component { initialState, render, update } {}

initialState :: State
initialState =
  {}

render :: Self Props State Action -> JSX
render self =
  H.div
  { className: intercalate " " ["app", Style.section]
  , children:
    [ H.style_
      [ H.text (getStyle Style.sheet) ]
    , H.div
      { className: "header"
      , children:
        [ H.h1
          { className: Style.title
          , children: [ H.text "Timer" ]
          }
        ]
      }
    , H.div
      { className: "body"
      , children: [ Form.form {} ]
      }
    , H.div
      { className: "footer" }
    ]
  }

update :: Self Props State Action -> Action -> StateUpdate Props State Action
update self Noop = NoUpdate
