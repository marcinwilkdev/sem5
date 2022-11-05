getPerfectNumbers n = filter (\k -> k == getDivisorsSum k) [1 .. n]

getNumbersWithDivisorsSum n = map (\k -> (k, getDivisorsSum k)) [1 .. n]

getNumbersWithDivisors n = map (\k -> (k, getDivisors k)) [1 .. n]

getDivisorsSum n = sum $ getDivisors n

getDivisors n = filter (\k -> mod n k == 0) (1 : [2 .. (n - 1)])
