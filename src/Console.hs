{-# LANGUAGE RecordWildCards, TemplateHaskell #-}
module Main where

import Control.Monad.Cont (liftIO)
import Control.Monad.Identity (Identity, runIdentity)
import Control.Monad.RWS (get)
import Control.Monad.State (State, StateT, mapStateT, evalStateT, modify)
import Ratscrew.Game

type ConsoleView = String

main :: IO ()
main = evalStateT gameLoop $ newGame getPlayers

gameLoop ::  StateT Game IO ()
gameLoop = do
        c <- liftIO getChar
        winner <- stateLift $ gameAction c
        game <- get
        liftIO $ printView game 
        case winner of
          Just _ -> return ()
          _ -> gameLoop

stateLift :: StateT a Identity b -> StateT a IO b
stateLift = mapStateT (return . runIdentity)
            
printView :: Game -> IO ()
printView = putStrLn . consoleView .  gameView

consoleView :: GameView -> ConsoleView
consoleView g@(GameView {..}) = maybe (inProgressView g) (("The winner is " ++) . show) gameWinner

getWinner :: Game -> Maybe Player
getWinner = gameWinner . gameView

gameAction :: Char -> State Game (Maybe Player)
gameAction c = do
  gameAction' c
  g <- get 
  return $ getWinner g
            
gameAction' :: Char -> State Game ()
gameAction' 'q' = modify $ playCard toby
gameAction' 'w' = modify $ attemptSnap toby
gameAction' 'o' = modify $ playCard mike
gameAction' 'p' = modify $ attemptSnap mike
gameAction' _ = return ()


                
inProgressView :: GameView -> ConsoleView
inProgressView (GameView {..}) = 
                  unlines
                            [ maybe "Empty stack" (("Top Card: " ++).show) topCard
                            , maybe "Count not started" (("Count: " ++) . show) currentCount
                            , "Cards in stack: " ++ show stackSize
                            , maybe "No players able to play"
                                        (("Current player: " ++) . show) currentPlayer
                            ]

getPlayers :: [Player]
getPlayers = [toby, mike]
             
toby :: Player
toby = Player "Toby"

mike :: Player
mike = Player "Mike"
