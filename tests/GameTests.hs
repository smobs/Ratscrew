module GameTests where

import Test.Tasty
import Test.Tasty.HUnit
import Game

tests :: TestTree
tests = testGroup "Game Tests" [
         unitTests
        ]


unitTests :: TestTree
unitTests = testGroup "Unit Tests" [
             testCase "New Game has an empty stack" $
                      let game = Game.gameView $ Game.newGame [] in
                      assertFailure "In progress"
            ]
