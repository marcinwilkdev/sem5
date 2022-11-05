fib 0 = 1
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

anotherFibb n = anotherFib n 1 1

anotherFib 0 _ n = n
anotherFib 1 _ n = n
anotherFib n first second = anotherFib (n - 1) second (first + second)
