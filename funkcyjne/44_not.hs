ssm [] = []
ssm (x : xs) = partial $ filter (> x) xs

partial arr = map (`take` arr) [0 .. length arr - 1]
