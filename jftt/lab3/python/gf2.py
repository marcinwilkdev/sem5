from typing import List

GF2_MAX_VALUE = 1234576


class GF2:
    number: int

    def __init__(self, number: int):
        while number < 0:
            number += GF2_MAX_VALUE

        self.number = number % GF2_MAX_VALUE

    def neutral(self) -> "GF2":
        try:
            return GF2(0)
        except GF2Exception:
            exit(-1)

    def __add__(self, other: "GF2") -> "GF2":
        return GF2(self.number + other.number)

    def __sub__(self, other: "GF2") -> "GF2":
        return GF2(self.number - other.number)

    def __mul__(self, other: "GF2") -> "GF2":
        return GF2(self.number * other.number)

    def __truediv__(self, other: "GF2") -> "GF2":
        return self * other.inverse()

    def __pow__(self, other: "GF2") -> "GF2":
        number = self.number
        result = 1

        power = other.number

        while power > 0:
            if power % 2 == 1:
                result = (result * number) % GF2_MAX_VALUE

            number = (number * number) % GF2_MAX_VALUE
            power = power // 2

        return GF2(result)

    def __gt__(self, other: "GF2") -> bool:
        return self.number > other.number

    def __lt__(self, other: "GF2") -> bool:
        return self.number < other.number

    def __eq__(self, other: "GF2") -> bool:
        return self.number == other.number

    def __str__(self) -> str:
        return str(self.number)

    def value(self) -> int:
        return self.number

    def inverse(self) -> "GF2":
        if self.number == 0:
            raise GF2NoInverseException

        [a, x, _] = gcd(self.number, GF2_MAX_VALUE)

        if a > 1:
            raise GF2NoInverseException

        return GF2(x)


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


class GF2Exception(Exception):
    pass


class GF2NoInverseException(GF2Exception):
    pass
