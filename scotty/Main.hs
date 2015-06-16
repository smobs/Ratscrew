{-# LANGUAGE OverloadedStrings #-}
module Main where

import Web.Scotty

main :: IO ()
main = scotty 3000 $
         get "/:word" $ do
                       beam <- param "word"
                       html $ mconcat ["Hello ", beam, " world"]
