fact 0 = 1
fact 1 = 1
fact n = n * fact (n - 1)

myGcd a b = if a < b then myGcd' b a else myGcd' a b

myGcd' a 0 = a
myGcd' a b = myGcd' b (a `mod` b)

diof a b c = if c `mod` d == 0 then (x * (c `div` d), y * (c `div` d)) else error "No solution"
  where
    (x, y) = diof' a b
    d = myGcd a b

diof' a b = if b == 0 then (1, 0) else (y, x - (a `div` b) * y)
  where
    (x, y) = diof' b (a `mod` b)
