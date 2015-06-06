module Ratscrew.Types.Arbitrary where

import Ratscrew.Types
import Test.Tasty.QuickCheck
import Control.Monad (liftM)

instance Arbitrary Player where
    arbitrary = liftM Player arbitrary
    shrink = map Player . shrink . playerID 

