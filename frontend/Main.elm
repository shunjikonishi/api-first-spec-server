module Main exposing(main)

import Html exposing (h1, div, text)

main = div [] [title, body]

title = h1 [] [text "API first spec server"]
body = div [] [text "Hello Worldx"]