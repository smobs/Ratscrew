module Ratscrew.Game.Internal.Snapping
(
isSnap
)
where

import Ratscrew.Cards
import Control.Applicative

isSnap :: Int -> [Card] -> Bool
isSnap i = listOr [ darkQueen, normalSnap, sandwichSnap, matchesCount i]


listOr :: [[Card] -> Bool] -> [Card] -> Bool
listOr fs cs = any  (\f -> f cs) fs  

darkQueen :: [Card] -> Bool
darkQueen cs = case cs of
                 (Card Queen Spades : _) -> True
                 _ -> False

normalSnap :: [Card] -> Bool
normalSnap  = nthSnap 0

sandwichSnap :: [Card] -> Bool
sandwichSnap = nthSnap 1

nthSnap :: Int -> [Card] -> Bool
nthSnap i cs = any f $ zip cs (drop (i+1) cs)
                where f (Card r1 _,Card r2 _) = r1 == r2 

matchesCount :: Int -> [Card] -> Bool
matchesCount i (Card r s : _) = case (i, r) of
                           (1, Ace) -> True
                           (2, Two) -> True
                           (3, Three) -> True
                           (4, Four) -> True
                           (5, Five) -> True
                           (6, Six) -> True
                           (7, Seven) -> True
                           (8, Eight) -> True
                           (9, Nine) -> True
                           (10, Ten) -> True
                           (11, Jack) -> True
                           (12, Queen) -> True
                           (13, King) -> True
                           _ -> False
matchesCount _ _ = False
