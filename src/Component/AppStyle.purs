module Component.AppStyle
  ( section
  , sheet
  ) where

import PureStyle (StyleSheet, createStyleSheet, registerStyle)

sheet :: StyleSheet
sheet = createStyleSheet

global :: String
global = registerStyle sheet """
  html, body {
    padding: 0;
  }
"""

section :: String
section = registerStyle sheet """
  .& {
    margin: 0 auto;
    width: 400px;
  }
"""
