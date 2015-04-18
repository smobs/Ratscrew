module Main where
import Test.Tasty 
import qualified Ratscrew.Game.Tests
import qualified Ratscrew.Game.Internal.Snapping.Tests

main :: IO ()
main = defaultMain $ testGroup "Tests" [
        Ratscrew.Game.Tests.tests,
        Ratscrew.Game.Internal.Snapping.Tests.tests
       ]

