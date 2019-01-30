module Component.FormStyle
  ( button
  , label
  , form
  , value
  ) where

import Component.AppStyle (sheet)
import PureStyle (registerStyle)

button :: String
button = registerStyle sheet """
  .& {
    background-color: #dddddd;
    border: none;
    box-shadow: 2px 2px rgba(0, 0, 0, 0.3);
    cursor: pointer;
    font-size: 16px;
    height: 32px;
    width: 100%;
  }
  .&:hover {
    box-shadow: 2px 2px rgba(0, 0, 0, 0.7);
  }
  .&:active {
    box-shadow: 0 0;
  }
"""

label :: String
label = registerStyle sheet """
  .& {
    display: inline-block;
    width: 30%;
  }
"""
form :: String
form = registerStyle sheet """
  .& {
    margin: 0 auto;
    width: 400px;
  }
"""

value :: String
value = registerStyle sheet """
  .& {
    display: inline-block;
    margin: 0;
    padding: 0;
    width: 70%;
  }
"""
