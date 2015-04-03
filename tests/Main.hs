module Main where
import Test.Tasty 
import qualified GameTests
    
main :: IO ()
main = defaultMain $ testGroup "Tests" [
        GameTests.tests
       ]

