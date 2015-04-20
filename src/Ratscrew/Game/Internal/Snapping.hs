module Ratscrew.Game.Internal.Snapping
(
isSnap
)
where

import Ratscrew.Cards
import Control.Applicative

isSnap :: Int -> [Card] -> Bool
isSnap _ = (||) <$> darkQueen <*> normalSnap

darkQueen :: [Card] -> Bool
darkQueen cs = case cs of
                 (Card Queen Spades : _) -> True
                 _ -> False

normalSnap :: [Card] -> Bool
normalSnap cs = any f $ zip cs (drop 1 cs)
                where f (Card r1 _,Card r2 _) = r1 == r2 
