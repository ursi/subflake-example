module Main where

import Prelude

import Effect (Effect)
import Effect.Console (log)

main :: Effect Unit
-- you can change this to whatever you want
-- then run `nix run .#ps-15` on the left
-- it it will be reflected right away
-- even though this is a child-flake
-- no updating of the lock file needed
main = log "PureScript 0.15"
