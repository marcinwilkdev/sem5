func arr = foldl (\acc (idx, x) -> if even idx then acc + x else acc - x) 0 (zip [2 ..] arr)
