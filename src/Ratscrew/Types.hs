{-# LANGUAGE DeriveDataTypeable#-}
module Ratscrew.Types where
    
import Ratscrew.Cards
import Data.Typeable

data Player = Player {
           playerID :: String
           }
              deriving (Show, Eq, Ord)
    
data PlayerView = PlayerView {
      player :: Player,
      cards :: Int,
      hasPenalty :: Bool
    }
                  deriving Show
                 
data GameView = GameView {
             gameWinner :: Maybe Player,
             topCard :: Maybe Card,
             currentCount :: Maybe Int,
             stackSize :: Int,
             players :: [PlayerView],
             currentPlayer :: Player,
             playLog :: [String]
           }
              deriving (Show, Typeable)
