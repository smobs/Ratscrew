module Ratscrew.Game.Internal.Snapping.Tests
where

import Test.Tasty
import Test.Tasty.QuickCheck
import Ratscrew.Cards
import Ratscrew.Cards.Arbitrary
import qualified Ratscrew.Game.Internal.Snapping as Snapping

tests :: TestTree
tests = testGroup "Snapping tests" [properties]



properties :: TestTree
properties = 
              testGroup "QC Properties" 
                            [ testProperty "Empty list has no snaps" emptyProp
                            , testProperty "Dark queen on top always snaps" darkQueen 
                            ]

emptyProp :: Int -> Bool
emptyProp i = not (fut i [])

darkQueen :: Int -> [Card] -> Bool
darkQueen i cs = fut i $ Card Queen Spades : cs

fut :: Int ->  [Card] -> Bool
fut = Snapping.isSnap 
