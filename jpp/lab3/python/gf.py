MAX_VALUE = 1234567891


class GF:
    number: int

    def __init__(self, number: int):
        if number < 0:
            raise GFNegativeException("Number cannot be negative!")

        if number >= MAX_VALUE:
            raise GFTooBigException(
                "Number cannot be greater than: {}".format(MAX_VALUE)
            )

        self.number = number

    def __add__(self, other):
        new_value = (self.number + other.number) % MAX_VALUE
        return GF(new_value)

    def __sub__(self, other):
        new_value = (self.number - other.number) % MAX_VALUE

        if new_value < 0:
            new_value += MAX_VALUE

        return GF(new_value)

    def __mul__(self, other):
        new_value = (self.number * other.number) % MAX_VALUE
        return GF(new_value)

    def __floordiv__(self, other):
        if other.number == 0:
            raise GFDivisionByZeroException

        new_value = (self.number // other.number)
        return GF(new_value)

    def __gt__(self, other):
        return self.number > other.number

    def __lt__(self, other):
        return self.number < other.number

    def __equals__(self, other):
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
