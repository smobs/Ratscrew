module Ratscrew.Cards.Arbitrary where

import Ratscrew.Cards
import Test.Tasty.QuickCheck


instance Arbitrary Suit where
    arbitrary = oneof (map return [Diamonds .. Spades])

instance Arbitrary Rank where
    arbitrary = oneof $ map return [Ace .. King]

instance Arbitrary Card where
    arbitrary = do
        s <- arbitrary
        r <- arbitrary
        return (Card s r)
