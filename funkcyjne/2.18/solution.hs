firstFib n = if n == 0 || n == 1 then 1 else firstFib (n - 2) + firstFib (n - 1)
secondFib n = if n == 0 || n == 1 then 1 else firstFib (n - 2) + firstFib (n - 1)
