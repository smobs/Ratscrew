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
                            , testProperty "Two side by side cards with the same rank is a snap." normalSnap
                            , testProperty "Two cards with the same rank one apart is a snap" sandwichSnap
                            , testProperty "Top card matches the count" countMatchingSnap
                            ]


countMatchingSnap :: [Card] -> (Rank, Suit) -> Bool
countMatchingSnap cs (r, s) = fut (rankScore r) (Card r s : cs)

rankScore :: Rank -> Int
rankScore r = case r of
                Ace -> 1
                Two -> 2
                Three -> 3
                Four -> 4
                Five -> 5
                Six -> 6
                Seven -> 7
                Eight -> 8
                Nine -> 9
                Ten -> 10
                Jack -> 11
                Queen -> 12
                King -> 13

emptyProp :: Int -> Bool
emptyProp i = not (fut i [])

darkQueen :: Int -> [Card] -> Bool
darkQueen i cs = fut i $ Card Queen Spades : cs

normalSnap :: Int -> ([Card],[Card]) -> Rank -> (Suit, Suit) -> Bool
normalSnap i d r = fut i . singleSnap d r

sandwichSnap :: Int -> ([Card],Card,  [Card]) -> Rank -> (Suit, Suit) -> Bool
sandwichSnap i d r = fut i . oneApart d r

oneApart :: ([Card], Card, [Card]) -> Rank -> (Suit, Suit) -> [Card]
oneApart (d1, c, d2) r (s1, s2) = d1 ++ [Card r s1, c, Card r s2] ++ d2

singleSnap :: ([Card], [Card]) -> Rank -> (Suit, Suit) -> [Card]
singleSnap (d1, d2)  r (s1, s2) = d1 ++ [Card r s1, Card r s2] ++ d2


fut :: Int ->  [Card] -> Bool
fut = Snapping.isSnap 
