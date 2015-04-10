module Ratscrew.Game.Tests where

import Test.Tasty
import Test.Tasty.HUnit
import Ratscrew.Game

tests :: TestTree
tests = testGroup "Game Tests" [
         unitTests
        ]


unitTests :: TestTree
unitTests = let testPlayers = [Player "aToby", Player "Mike"]
                game = gameView $ newGame testPlayers in 
                            testGroup "Unit Tests" 
            [ testCase "New Game has no winner" $
                       assertEqual "New game has no winner" Nothing (gameWinner game)  
            , testCase "View has all players" $
                       assertEqual "Same players" (reverse testPlayers) $ map player (players game)
            ]
