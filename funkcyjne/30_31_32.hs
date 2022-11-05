myinits arr = map (firstN arr) [0 .. (length arr)]

firstN _ 0 = []
firstN [] _ = []
firstN (x : xs) n = x : firstN xs (n - 1)

mytails arr = map (lastN arr (length arr)) [0 .. (length arr)]

lastN _ _ 0 = []
lastN [] _ _ = []
lastN (x : xs) n k =
  if n > k
    then lastN xs (n - 1) k
    else x : lastN xs (n - 1) (k - 1)

partitions arr = zip (reverse $ myinits arr) (mytails arr)
