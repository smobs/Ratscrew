{-# LANGUAGE OverloadedStrings #-}
module Main where

import Web.Scotty
import Network.Wai.Middleware.Static
import Ratscrew.Game
import Data.IORef
import Data.Aeson (ToJSON, toJSON, object, (.=))
import Control.Monad.IO.Class

main :: IO ()
main = do
    ref <- newIORef $ newGame [Player "Toby", Player "Mike"]
    scotty 3000 $ do
         middleware staticFileServer 
         handlers ref

handlers :: IORef Game -> ScottyM ()
handlers ref =
           do
             get "/" (file "static/index.html")
             get "/gameState" (viewGame ref)
             get "/playCard" (playCardAction ref)


viewGame :: IORef Game -> ActionM ()
viewGame ref = do
  game <- liftIO $ readIORef ref
  json (gameView game)

playCardAction :: IORef Game -> ActionM ()
playCardAction ref = do 
  liftIO $ modifyIORef ref (playCard (Player "Toby"))
  viewGame ref
staticFileServer = staticPolicy p
                   where p = addBase "static"

instance ToJSON GameView where
    toJSON (GameView winner tc count size ps current pl) 
        = object ["gameWinner" .= winner
                 , "topCard" .= tc
                 , "currentCount" .= count
                 , "stackSize" .= size
                 , "players" .=  ps
                 , "currentPlayer" .= current
                 , "playLog" .= pl
                 ]

instance ToJSON Player where
    toJSON (Player s) = toJSON s

instance ToJSON Card where
    toJSON (Card r s) = object ["suit" .= show s, "rank" .= show r]

instance ToJSON PlayerView where
    toJSON (PlayerView name stackCount isPenalised) = object ["name" .= name, "cards" .= stackCount, "hasPenalty" .= isPenalised]

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
