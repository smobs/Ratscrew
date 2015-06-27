{-# LANGUAGE TemplateHaskell, RecordWildCards, DeriveDataTypeable #-}
module Ratscrew.Game
    (
     module Ratscrew.Types,
     module Ratscrew.Cards,
     attemptSnap,
     gameView,
     playCard,
     newGame,
     Game()
    )
where

import Ratscrew.Cards
import Control.Lens
import Ratscrew.Types
import Data.Typeable
import Ratscrew.Game.Internal
import Ratscrew.Game.Internal.Snapping as Snapping

newtype Game = Game {_gameState :: GameState}
    deriving Typeable

makeLenses ''Game
                    
attemptSnap :: Player -> Game -> Game
attemptSnap = withGameState (attemptSnap' (Snapping.isSnap (-1)))
              
playCard :: Player -> Game -> Game
playCard = withGameState playCard'

gameView :: Game -> GameView
gameView (Game g) = gameView' g

newGame :: [Player] -> Game
newGame p = let d = fullDeck in
            Game (MkGameState [] (newPlayers p d) Nothing Nothing)

withGameState ::(a -> GameState -> GameState) -> a -> Game -> Game 
withGameState f p = gameState %~ f p
