module Ratscrew.Cards.Arbitrary where

import Ratscrew.Cards
import Test.Tasty.QuickCheck


instance Arbitrary Suit where
    arbitrary = return Spades

instance Arbitrary Rank where
    arbitrary = return Ace

instance Arbitrary Card where
    arbitrary = do
        s <- arbitrary
        r <- arbitrary
        return (Card s r)
