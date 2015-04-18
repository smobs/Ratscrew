{-# LANGUAGE TemplateHaskell, RecordWildCards, DeriveDataTypeable #-}
module Ratscrew.Game.Internal
(
 module Ratscrew.Game.Internal ,
 module Ratscrew.Cards
)
where

import Ratscrew.Cards
import Control.Applicative (Applicative)
import Control.Lens
import Control.Monad.State (State)
import qualified Data.List as L
import qualified Data.Map as Map
import Data.Map.Lazy (Map)
import qualified Data.Maybe as M
import Ratscrew.Types

data PlayerState = PlayerState {_penalised :: Bool,
                                _playerStack :: [Card]
                               }
                                  
data GameState = MkGameState {
      _snapStack :: [Card],
      _gamePlayers:: Map Player PlayerState,
      _gameCurrentPlayer :: Maybe Player,
      _gameCurrentCount :: Maybe Int
    }
               
makeLenses ''PlayerState
makeLenses ''GameState

attemptSnap' :: ([Card] -> Bool) -> Player -> GameState -> GameState
attemptSnap' f p g
                 | playerHasPenalty p g = g 
                 | not $ hasSnap f g = givePenalty p g 
                 | otherwise =  doSnap p g
               

doSnap :: Player -> GameState -> GameState
doSnap p g=
    let s = g ^. snapStack in
    g & gamePlayers . at p . _Just . playerStack %~ (++ s)
          & snapStack .~ [] 

playerHasPenalty :: Player -> GameState -> Bool
playerHasPenalty p g = M.fromMaybe False $ g ^? penaltyLens p

givePenalty :: Player -> GameState -> GameState
givePenalty p g = g & penaltyLens p .~ True

penaltyLens :: Applicative f => Player -> (Bool -> f Bool) -> GameState -> f GameState
penaltyLens p =  gamePlayers . at p . _Just . penalised

hasSnap :: ([Card] -> Bool) -> GameState -> Bool
hasSnap  f = f . view snapStack
                 
playCard' :: Player -> GameState -> GameState
playCard' p g = let c = playerTopCard p g in
              case c of
                Nothing -> g
                Just card -> g & (addToStack card . removePlayerTopCard p) 
    
playerTopCard :: Player -> GameState -> Maybe Card
playerTopCard p g = do
  PlayerState _ cs <- Map.lookup p (g ^. gamePlayers)
  M.listToMaybe cs
  

   
removePlayerTopCard :: Player -> GameState -> GameState
removePlayerTopCard p g = g & gamePlayers %~ Map.adjust removeCard p
                                 where
                                   removeCard (PlayerState pn []) = PlayerState pn []
                                   removeCard (PlayerState pn (_:xs)) = PlayerState pn xs
                      
addToStack :: Card -> GameState -> GameState
addToStack c = snapStack %~ (c :)

gameView' :: GameState -> GameView
gameView' g = GameView
          (getWinner g)
          (M.listToMaybe (g  ^. snapStack))
          (g ^. gameCurrentCount)
          (length (g ^. snapStack))
          (map playerView $ Map.toList $ g ^. gamePlayers)
          (g ^. gameCurrentPlayer)
          []
          
playerView :: (Player, PlayerState) -> PlayerView
playerView (p,s) = PlayerView p (length $ s ^. playerStack) (s ^. penalised) 

getWinner :: GameState -> Maybe Player
getWinner g =  anyWinners $  g ^. gamePlayers  
      
newPlayers :: [Player] -> Deck -> Map Player PlayerState
newPlayers ps d = let i = length ps in
                  (Map.fromList . zip ps) (map  newPlayerState (dealHands i d))

anyWinners :: Map Player PlayerState -> Maybe Player
anyWinners =
    let singleElement [x] = Just x
        singleElement _ = Nothing in
       singleElement . Map.keys . Map.filter hasCards 
             
hasCards :: PlayerState -> Bool 
hasCards = not . null . view playerStack 

dealHands :: Int -> Deck -> [[Card]]
dealHands i = map (map snd)
              . L.groupBy (\(x,_) (y,_) -> x == y)
              . L.sortBy(\(x,_) (y, _) -> compare x y)
              . zip [mod x i | x <- [0..]]
    
newPlayerState :: [Card] -> PlayerState
newPlayerState = PlayerState False

