rev :: [a] -> [a]
rev [] = []
rev (x:xs) = rev xs ++ [x]

-- Complexity O(n^2) (1 + 2 + .. + (n - 1)) steps
