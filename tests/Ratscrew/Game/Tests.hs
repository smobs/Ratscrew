module Ratscrew.Game.Tests where

import Test.Tasty
import Test.Tasty.HUnit
import Test.Tasty.QuickCheck
import Ratscrew.Game
import Ratscrew.Types.Arbitrary
import Data.List (nub)
import qualified Data.Set as Set
tests :: TestTree
tests = testGroup "Game Tests" [
         properties
        ]


properties :: TestTree
properties = testGroup "Properties" [testProperty "New Game has no winner" newGameHasNoWinner
                                    , testProperty "View has all players" viewHasAllPlayers]

viewHasAllPlayers :: [Player] -> Property
viewHasAllPlayers ps = asMultiplayerGame ps $ 
                       (===) <$> Set.fromList <*> Set.fromList . map player . players . gameView . newGame

newGameHasNoWinner :: [Player] -> Property
newGameHasNoWinner ps = asMultiplayerGame ps $ 
                        (Nothing ===) .  gameWinner . gameView . newGame


asMultiplayerGame :: [Player] -> ([Player] -> Property) -> Property
asMultiplayerGame ps p = let ups = nub ps 
                         in length ups > 1 ==> p ups
                        
