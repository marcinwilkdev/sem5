-- approx n = foldl (\acc x -> acc + 1.0 / fromIntegral (product [1..x])) 0.0 [1..n]
approx n = foldr (\x acc -> acc + 1.0 / fromIntegral (product [1..x])) 0.0 [1..n]
