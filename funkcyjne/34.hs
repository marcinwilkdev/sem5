myzip [] _ = []
myzip _ [] = []
myzip (x : xs) (y : ys) = (x, y) : myzip xs ys
