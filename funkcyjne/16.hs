euler n = length (filter (\k -> gcd k n == 1) [1..n])
sumEuler n = sum (map euler (filter (\k -> mod n k == 0) [1..n]))
