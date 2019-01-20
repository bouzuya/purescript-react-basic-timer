module Component.FormStyle
  ( button
  , form
  ) where

import Component.AppStyle (sheet)
import PureStyle (registerStyle)

form :: String
form = registerStyle sheet """
  .& {
    margin: 0 auto;
    width: 400px;
  }
"""

button :: String
button = registerStyle sheet """
  .& {
    background-color: transparent;
    border: none;
    height: 24px;
    width: 100%;
  }
"""
