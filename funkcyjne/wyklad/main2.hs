import Data.Semigroup;

data Writer a = Writer (a, String) deriving (Show)

instance Functor Writer where
  fmap f (Writer (x, s)) = Writer (f x, s)

instance Monad Writer where
  return x = Writer (x, "")
  (Writer (x, s)) >>= f = let Writer (y, s') = f x in Writer (y, s ++ s')

instance Applicative Writer where
  pure = return
  fw <*> xw = do f <- fw; x <- xw; return (f x)

half::Int -> Writer Int
half x = Writer (x `div` 2, "half " ++ show x ++ ";")
