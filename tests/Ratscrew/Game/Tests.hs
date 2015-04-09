module Ratscrew.Game.Tests where

import Test.Tasty
import Test.Tasty.HUnit
import Ratscrew.Game

tests :: TestTree
tests = testGroup "Game Tests" [
         unitTests
        ]


unitTests :: TestTree
unitTests = testGroup "Unit Tests" [
             testCase "New Game has an empty stack" $
                      let game = gameView $ newGame 
                                 [Player "Toby", Player "Mike"] in
                      assertEqual "New game has no winner" Nothing (gameWinner game)  
            ]
