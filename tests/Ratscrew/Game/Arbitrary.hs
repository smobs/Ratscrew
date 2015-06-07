module Ratscrew.Game.Arbitrary 
where

import Ratscrew.Game
import Ratscrew.Types.Arbitrary
import Test.Tasty
import Test.Tasty.QuickCheck
import qualified Data.Maybe as M

instance Show Game where
    show = show . gameView


data GameCommand = PlayCommand Player | SnapCommand Player

instance Arbitrary GameCommand where
    arbitrary = do
      p <- arbitrary
      oneof [return $ PlayCommand p, return $ SnapCommand p]

arbCommand :: [Player] ->  Gen GameCommand
arbCommand ps = do
  p <- oneof $ map return  ps
  c <- oneof $ map return [PlayCommand, SnapCommand]
  return $ c p

instance Arbitrary Game where
    arbitrary = do
      ps <- listOf1  arbitrary
      commands <- listOf $ arbCommand ps
      return $ createGame ps commands

newtype FinishedGame = MkGame {getGame :: Game} deriving Show

instance Arbitrary FinishedGame where
    arbitrary = do
      g <- arbitrary
      suchThat (return $ MkGame g) hasWinner
          where hasWinner = M.isJust . gameWinner . gameView . getGame
createGame :: [Player] -> [GameCommand] -> Game
createGame ps = foldr f (newGame ps) 
               where f (SnapCommand pl)  = attemptSnap pl
                     f (PlayCommand pl) = playCard pl

tests :: TestTree
tests = testGroup "Arbitrary.Game tests" [
--hangs         testProperty "Finished games have a winner" finishedGamesHaveAWinner
        ]

finishedGamesHaveAWinner :: FinishedGame -> Bool
finishedGamesHaveAWinner = M.isJust . gameWinner . gameView . getGame
