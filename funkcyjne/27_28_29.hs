mymap :: (a -> b) -> [a] -> [b]
mymap f [] = []
mymap f (x : xs) = f x : mymap f xs

mysum arr = map (\n -> sum $ take n arr) [1 .. length arr]

myproduct [] = 1
myproduct (x : xs) = x * myproduct xs

myfact 0 = 1
myfact n = myproduct [1 .. n]

mynub arr = mynub_ arr []

mynub_ [] arr = arr
mynub_ (x : xs) arr =
  if elem x arr
    then mynub_ xs arr
    else mynub_ xs (arr ++ [x])
