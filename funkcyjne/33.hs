nondec [] = True
nondec (x : xs) = nondec_ x xs

nondec_ _ [] = True
nondec_ y (x : xs) = (x >= y) && nondec_ x xs

myzip _ [] = []
myzip [] _ = []
myzip (x : xs) (y : ys) = (x, y) : myzip xs ys
