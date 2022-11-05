anotherFibb n = anotherFib n 1 1

anotherFib 0 _ n = n
anotherFib 1 _ n = n
anotherFib n first second = anotherFib (n - 1) second (first + second)
