from polynomialType import PolynomialType


class DoubleWrapper(PolynomialType):
    value: float

    def __init__(self, number: float):
        self.value = number

    def neutral(self) -> "DoubleWrapper":
        return DoubleWrapper(0.0)

    def __add__(self, other: "DoubleWrapper") -> "DoubleWrapper":
        return DoubleWrapper(self.value + other.value)

    def __sub__(self, other: "DoubleWrapper") -> "DoubleWrapper":
        return DoubleWrapper(self.value - other.value)

    def __mul__(self, other: "DoubleWrapper") -> "DoubleWrapper":
        return DoubleWrapper(self.value * other.value)

    def __truediv__(self, other: "DoubleWrapper") -> "DoubleWrapper":
        return DoubleWrapper(self.value / other.value)

    def __pow__(self, other: int) -> "DoubleWrapper":
        return DoubleWrapper(pow(self.value, other))

    def __gt__(self, other: "DoubleWrapper") -> bool:
        return self.value > other.value

    def __lt__(self, other: "DoubleWrapper") -> bool:
        return self.value < other.value

    def __eq__(self, other: "DoubleWrapper") -> bool:
        return self.value == other.value

    def __str__(self) -> str:
        return str(self.value)
