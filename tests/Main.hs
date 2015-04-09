module Main where
import Test.Tasty 
import qualified Ratscrew.Game.Tests
    
main :: IO ()
main = defaultMain $ testGroup "Tests" [
        Ratscrew.Game.Tests.tests
       ]

