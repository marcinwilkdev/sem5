myFoldr f acc [] = acc
myFoldr f acc (x:xs) = f x (myFoldr f acc xs)

myFoldl f acc [] = acc
myFoldl f acc (x:xs) = myFoldl f (f acc x) xs

evenCount arr = foldr (\x acc -> if even x then acc + 1 else acc) 0 arr

nondec [] = True
nondec [a] = True
nondec (x:y:xs)
 | x > y = False
 | otherwise = nondec (y:xs)

-- foldl (-) e xs = e - sum xs -- True
-- foldr (-) e xs = x1 - sum xs - e

