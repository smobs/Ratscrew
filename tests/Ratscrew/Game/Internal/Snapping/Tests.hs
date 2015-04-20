module Ratscrew.Game.Internal.Snapping.Tests
where

import Test.Tasty
import Test.Tasty.QuickCheck
import Ratscrew.Cards
import Ratscrew.Cards.Arbitrary()
import qualified Ratscrew.Game.Internal.Snapping as Snapping


tests :: TestTree
tests = testGroup "Snapping tests" [properties]



properties :: TestTree
properties = 
              testGroup "QC Properties" 
                            [ testProperty "Empty list has no snaps" emptyProp
                            , testProperty "Dark queen on top always snaps" darkQueen
                            , testProperty "Two side by side cards is a snap." normalSnap
                            ]

emptyProp :: Int -> Bool
emptyProp i = not (fut i [])

darkQueen :: Int -> [Card] -> Bool
darkQueen i cs = fut i $ Card Queen Spades : cs

normalSnap :: Int -> ([Card],[Card]) -> Rank -> (Suit, Suit) -> Bool
normalSnap i d r = fut i . singleSnap d r


singleSnap :: ([Card], [Card]) -> Rank -> (Suit, Suit) -> [Card]
singleSnap (d1, d2)  r (s1, s2) = d1 ++ [Card r s1, Card r s2] ++ d2

fut :: Int ->  [Card] -> Bool
fut = Snapping.isSnap 
