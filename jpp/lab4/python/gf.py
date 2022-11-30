import polynomialType

MAX_VALUE = 2


class GF(polynomialType.PolynomialType):
    number: int

    def __init__(self, number: int):
        if number < 0:
            raise GFNegativeException("Number cannot be negative!")

        if number >= MAX_VALUE:
            raise GFTooBigException(
                "Number cannot be greater than: {}".format(MAX_VALUE)
            )

        self.number = number

    def neutral(self) -> "GF":
        try:
            return GF(0)
        except GFException:
            exit(-1)

    def __add__(self, other: "GF") -> "GF":
        new_value = (self.number + other.number) % MAX_VALUE

        return GF(new_value)

    def __sub__(self, other: "GF") -> "GF":
        new_value = (self.number - other.number) % MAX_VALUE

        if new_value < 0:
            new_value += MAX_VALUE

        return GF(new_value)

    def __mul__(self, other: "GF") -> "GF":
        new_value = (self.number * other.number) % MAX_VALUE
        return GF(new_value)

    def __truediv__(self, other: "GF") -> "GF":
        if other.number == 0:
            raise GFDivisionByZeroException

        new_value = self.number // other.number
        return GF(new_value)

    def __pow__(self, other: int) -> "GF":
        number = self.number
        result = 1

        power = other

        while power > 0:
            if power % 2 == 1:
                result = (result * number) % MAX_VALUE

            number = (number * number) % MAX_VALUE
            power = power // 2

        return GF(result)

    def __gt__(self, other: "GF") -> bool:
        return self.number > other.number

    def __lt__(self, other: "GF") -> bool:
        return self.number < other.number

    def __eq__(self, other: "GF") -> bool:
        return self.number == other.number

    def __str__(self) -> str:
        return "GF({})".format(self.number)


class GFException(Exception):
    pass


class GFNegativeException(GFException):
    pass


class GFTooBigException(GFException):
    pass


class GFDivisionByZeroException(GFException):
    pass
