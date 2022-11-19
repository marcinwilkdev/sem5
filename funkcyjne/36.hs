countZeros n = min (sum $ map (roundLog 2) $ filter even [1 .. n]) (sum $ map (roundLog 5) $ filter (\x -> mod x 5 == 0) [1 .. n])

roundLog k n
  | mod n k > 0 = 0
  | otherwise = 1 + roundLog k (div n k)
