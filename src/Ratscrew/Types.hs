module Ratscrew.Types where
    
import Ratscrew.Cards

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
             currentPlayer :: Maybe Player,
             playLog :: [String]
           }
              deriving Show
