module Ratscrew.Cards where
    
data Rank = Ace | Two | Three | Four | Five | Six | Seven | Eight | Nine | Ten | Jack | Queen | King
          deriving (Show, Bounded, Enum, Eq, Ord)
data Suit = Diamonds | Clubs | Hearts | Spades
          deriving (Show, Bounded, Enum, Eq, Ord)

data Card = Card Rank Suit

instance Show Card where
    show (Card r s) = (show r) ++ " of " ++ (show s)
                      
type Deck = [Card]
          
fullDeck :: Deck
fullDeck = [Card r s | r <- [Ace .. King], s <- [Diamonds .. Spades]]
