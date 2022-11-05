binomial n 0 = 1
binomial n k = div (n * binomial (n - 1) (k - 1)) k
-- binomial n k = n * binomial (n - 1) (k - 1) / k
