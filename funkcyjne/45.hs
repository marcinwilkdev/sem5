remdupl arr = foldr (\x acc -> if elem x acc then acc else x : acc) [] arr
