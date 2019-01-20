module AppStyle
  ( button
  , form
  , sheet
  ) where

import PureStyle (StyleSheet, createStyleSheet, registerStyle)

sheet :: StyleSheet
sheet = createStyleSheet

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
