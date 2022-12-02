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
        new_value = (self.number + other.number) % GF2_MAX_VALUE

        return GF2(new_value)

    def __sub__(self, other: "GF2") -> "GF2":
        new_value = (self.number - other.number) % GF2_MAX_VALUE

        if new_value < 0:
            new_value += GF2_MAX_VALUE

        return GF2(new_value)

    def __mul__(self, other: "GF2") -> "GF2":
        new_value = (self.number * other.number) % GF2_MAX_VALUE
        return GF2(new_value)

    def __truediv__(self, other: "GF2") -> "GF2":
        if other.number == 0:
            raise GF2DivisionByZeroException

        new_value = self.number // other.number
        return GF2(new_value)

    def __pow__(self, other: int) -> "GF2":
        number = self.number
        result = 1

        power = other

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
        return "GF2({})".format(self.number)

    def value(self) -> int:
        return self.number


class GF2Exception(Exception):
    pass


class GF2DivisionByZeroException(GF2Exception):
    pass
