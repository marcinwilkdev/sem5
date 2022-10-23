isSqrt x = x == floor (sqrt (fromIntegral x)) ^ 2

pythagoreanTriple = concatMap (\a -> filter (\(_, b, c) -> gcd b c == 1) (map (\(a, b, cSquared) -> (a, b, floor (sqrt (fromIntegral cSquared)))) (filter (\(_, _, cSquared) -> isSqrt cSquared) (map (\b -> (a, b, a ^ 2 - b ^ 2)) [1 .. a])))) [1 .. 200]
