myTakeWhile _ [] = []
myTakeWhile p (x : xs) = if p x then x : myTakeWhile p xs else []

myDropWhile _ [] = []
myDropWhile p (x : xs) = if p x then myDropWhile p xs else xs
