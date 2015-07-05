module Ratscrew.Game.Tests where

import Test.Tasty
import Test.Tasty.HUnit
import Test.Tasty.QuickCheck
import Ratscrew.Game
import Ratscrew.Types.Arbitrary
import Ratscrew.Game.Arbitrary
import Data.List (nub)
import qualified Data.Maybe as M
import qualified Data.Set as Set
tests :: TestTree
tests = testGroup "Game Tests" [
         properties
        ]

properties :: TestTree
properties = testGroup "Properties" [testProperty "New Game has no winner" newGameHasNoWinner
                                    , testProperty "View has all players" viewHasAllPlayers
                                    , testProperty "Out of turn play is penalised" outOfTurnPlayIsPenalised
                                    ]

viewHasAllPlayers :: [Player] -> Property
viewHasAllPlayers ps = asMultiplayerGame ps $ 
                       (===) <$> Set.fromList <*> Set.fromList . map player . players . gameView . newGame

newGameHasNoWinner :: [Player] -> Property
newGameHasNoWinner ps = asMultiplayerGame ps $ 
                        (Nothing ===) .  gameWinner . gameView . newGame


outOfTurnPlayIsPenalised :: Game -> Property
outOfTurnPlayIsPenalised g = (length . players . gameView) g > 1 ==>
                             forAll (oneof $ map (\p -> return (p, playCard p g)) 
                                               $ outOfTurnPlayers g) 
                                        (\(ootp, updatedGame) -> 
                                           property $ playerIsPenalised ootp updatedGame )
                                
outOfTurnPlayers :: Game -> [Player]
outOfTurnPlayers g = filter (currentPlayer state /=)
                     . map player 
                     . players $ state
                     where state = gameView g


playerIsPenalised :: Player -> Game -> Bool
playerIsPenalised p = M.fromMaybe False 
                      .  M.listToMaybe  
                      . map hasPenalty 
                      . filter (\ps -> player ps == p)
                      . players 
                      . gameView
                        

asMultiplayerGame :: [Player] -> ([Player] -> Property) -> Property
asMultiplayerGame ps p = let ups = nub ps 
                         in length ups > 1 ==> p ups
                        
