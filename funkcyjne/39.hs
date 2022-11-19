-- sum :: (Foldable t, Num a) => t a -> a
-- Sums elements of foldable.
mySum = sum [1, 2, 3]
-- product :: (Foldable t, Num a) => t a -> a
-- Products elements of foldable.
myProduct = product [1, 2, 3]
-- all :: Foldable t => (a -> Bool) -> t a -> Bool
-- Checks if all elements of foldable satisfy given predicate.
allEven = all even [2, 4, 6]
-- any :: Foldable t => (a -> Bool) -> t a -> Bool
-- Checks if any element of foldable satisfies given predicate.
anyEven = any even [1, 3, 5]
