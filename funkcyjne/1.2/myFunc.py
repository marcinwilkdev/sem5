import math


def myFunc(x, y):
    return (lambda z: (lambda w: z + 2 * w))(x * y)


def anotherFunc(x, y):
    return lambda a: (x * y) + 2 * a


def sinFunc(x):
    return (lambda a: a * a + a + x)(math.sin(x))


def mySum(x):
    if len(x) == 0:
        return 0

    return x[0] + mySum(x[1:])


def product(x):
    if len(x) == 0:
        return 1

    return x[0] * product(x[1:])


def _myMin(x, curr_myMin):
    if len(x) == 0:
        return curr_myMin

    if x[0] < curr_myMin:
        curr_myMin = x[0]

    return _myMin(x[1:], curr_myMin)


def myMin(x):
    return _myMin(x, x[0])


def _myMax(x, curr_myMax):
    if len(x) == 0:
        return curr_myMax

    if x[0] > curr_myMax:
        curr_myMax = x[0]

    return _myMax(x[1:], curr_myMax)


def myMax(x):
    return _myMax(x, x[0])


def mySumSquares(n):
    if n == 0:
        return 0
    return n * n + mySumSquares(n - 1)


def main():
    print(myFunc(3, 5)(2))
    print(anotherFunc(3, 5)(2))
    print(sinFunc(1))
    print(mySum([1, 2, 3, 4]))
    print(product([1, 2, 3, 4]))
    print(myMin([5, 2, 3, 4]))
    print(myMax([1, 2, 3, 4]))
    print(mySumSquares(10))


if __name__ == "__main__":
    main()
