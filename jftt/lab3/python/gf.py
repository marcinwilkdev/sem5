GF_MAX_VALUE = 1234577


class GF:
    number: int

    def __init__(self, number: int):
        while number < 0:
            number += GF_MAX_VALUE

        self.number = number % GF_MAX_VALUE

    def neutral(self) -> "GF":
        try:
            return GF(0)
        except GFException:
            exit(-1)

    def __add__(self, other: "GF") -> "GF":
        new_value = (self.number + other.number) % GF_MAX_VALUE

        return GF(new_value)

    def __sub__(self, other: "GF") -> "GF":
        new_value = (self.number - other.number) % GF_MAX_VALUE

        if new_value < 0:
            new_value += GF_MAX_VALUE

        return GF(new_value)

    def __mul__(self, other: "GF") -> "GF":
        new_value = (self.number * other.number) % GF_MAX_VALUE
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
        return "GF({})".format(self.number)

    def value(self) -> int:
        return self.number


class GFException(Exception):
    pass


class GFDivisionByZeroException(GFException):
    pass
