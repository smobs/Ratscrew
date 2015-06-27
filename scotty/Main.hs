{-# LANGUAGE OverloadedStrings #-}
module Main where

import Web.Scotty
import Network.Wai.Middleware.Static

main :: IO ()
main = scotty 3000 $ do
         middleware staticFileServer 
         handlers

handlers :: ScottyM ()
handlers = get "/" $ 
             file "static/index.html"

staticFileServer = staticPolicy p
                   where p = addBase "static"
