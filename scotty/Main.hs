{-# LANGUAGE OverloadedStrings #-}
module Main where

import Web.Scotty
import Network.Wai.Middleware.Static
import Ratscrew.Game
import Data.IORef
import Data.Aeson (ToJSON, toJSON, object, (.=))

main :: IO ()
main = scotty 3000 $ do
         middleware staticFileServer 
         handlers

handlers :: ScottyM ()
handlers =
           do
             get "/" (file "static/index.html")
             get "/gameState" (json (gameView $ newGame [Player "Toby", Player "Mike"]))
staticFileServer = staticPolicy p
                   where p = addBase "static"

instance ToJSON GameView where
    toJSON (GameView winner topCard currentCount stackSize players currentPlayer playLog) 
        = object ["gameWinner" .= toJSON winner
                 , "topCard" .= toJSON topCard
                 , "currentCount" .= toJSON currentCount
                 , "stackSize" .= toJSON stackSize
                 , "players" .= toJSON players
                 , "currentPlayer" .= toJSON currentPlayer
                 , "playLog" .= toJSON playLog
                 ]

instance ToJSON Player where
    toJSON x = object []
instance ToJSON Card where
    toJSON x = object []
instance ToJSON PlayerView where
    toJSON x = object []

{--var data = {
    gameWinner : "Toby",
    topCard : {
        suit : "Spades",
        rank : "Queen"
    },
    currentCount : 2,
    stackSize : 1,
    players : [
        {name: "Toby", cards: 20},
        {name: "Mike", cards: 11}
    ],
    currentPlayer : "Toby",
    playLog : []
};
--}
