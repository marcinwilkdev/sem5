import Data.List

data Colors = Green | Orange | Red deriving (Show)

data DOW = Pon | Wto | Sro | Czw | Pia | Sob | Nie deriving (Show, Read, Eq, Ord, Enum, Bounded)

data Point a = Pt a a

data PointA a = PointA a a deriving ({- Show, -} Eq, Ord)

instance (Show a) => Show (PointA a) where
  show (PointA x y) = show (x, y)

instance Functor PointA where
  fmap f (PointA x y) = PointA (f x) (f y)

data BinTree a = Leaf a | Inner (BinTree a) (BinTree a) deriving (Eq)

instance (Show a) => Show (BinTree a) where
  show (Leaf a) = show a
  show (Inner lt rt) = "<" ++ show lt ++ "|" ++ show rt ++ ">"

mytree = Inner (Inner (Leaf 1) (Leaf 2)) (Leaf 5)

instance Functor BinTree where
  fmap f (Leaf a) = Leaf (f a)
  fmap f (Inner lt rt) = Inner (fmap f lt) (fmap f rt)

instance Foldable BinTree where
  foldr f base (Leaf a) = f a base
  foldr f base (Inner lt rt) = foldr f base' lt
    where
      base' = foldr f base rt

type Osoba = (Imie, Nazwisko)

type Imie = String

type Nazwisko = String

data MB a = Dokladnie a | Nic deriving (Eq, Show, Ord)

instance Functor MB where
  fmap _ Nic = Nic
  fmap f (Dokladnie a) = Dokladnie (f a)

pureMB x = Dokladnie x

safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x : xs) = Just x

safeTail :: [a] -> Maybe a
safeTail [] = Nothing
safeTail (x : xs) = Just x
