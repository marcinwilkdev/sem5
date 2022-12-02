from typing import List
from polynomialType import PolynomialType

GF_MAX_VALUE = 2


class GF(PolynomialType):
    number: int

    def __init__(self, number: int):
        while number < 0:
            number += GF_MAX_VALUE

        self.number = number % GF_MAX_VALUE

    def neutral(self) -> "GF":
        return GF(0)

    def __add__(self, other: "GF") -> "GF":
        return GF(self.number + other.number)

    def __sub__(self, other: "GF") -> "GF":
        return GF(self.number - other.number)

    def __mul__(self, other: "GF") -> "GF":
        return GF(self.number * other.number)

    def __truediv__(self, other: "GF") -> "GF":
        return self * other.inverse()

    def __pow__(self, other: int) -> "GF":
        number = self.number
        result = 1

        power = other

        while power > 0:
            if power % 2 == 1:
                result = (result * number) % GF_MAX_VALUE

            number = (number * number) % GF_MAX_VALUE
            power = power // 2

        return GF(result)

    def __gt__(self, other: "GF") -> bool:
        return self.number > other.number

    def __lt__(self, other: "GF") -> bool:
        return self.number < other.number

    def __eq__(self, other: "GF") -> bool:
        return self.number == other.number

    def __str__(self) -> str:
        return str(self.number)

    def value(self) -> int:
        return self.number

    def inverse(self) -> "GF":
        if self.number == 0:
            raise GFNoInverseException

        [a, x, _] = gcd(self.number, GF_MAX_VALUE)

        if a > 1:
            raise GFNoInverseException

        return GF(x)


def gcd(a: int, b: int) -> List[int]:
    x, y = 1, 0
    x1, y1 = 0, 1
    a1, b1 = a, b

    while b1 != 0:
        q = a1 // b1

        x, x1 = x1, x - q * x1
        y, y1 = y1, y - q * y1
        b1, a1 = a1 - q * b1, b1

    return [a1, x, y]


class GFException(Exception):
    pass


class GFNoInverseException(GFException):
    pass
