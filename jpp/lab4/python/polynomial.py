from typing import List, TypeVar, Generic
from polynomialType import PolynomialType

T = TypeVar("T", bound=PolynomialType)


class Polynomial(Generic[T]):
    coefficients: List[T]

    def __init__(self, coefficients: List[T]):
        self.coefficients = coefficients

    def normalize(self):
        if len(self.coefficients) == 0:
            return

        neutralElement = self.coefficients[0].neutral()

        for coeffIdx in reversed(range(len(self.coefficients))):
            if not (self.coefficients[coeffIdx] == neutralElement):
                break

            self.coefficients.pop()

    def __eq__(self, other: "Polynomial") -> bool:
        return self.coefficients == other.coefficients

    def __add__(self, other: "Polynomial") -> "Polynomial":
        maxLen = max(len(self.coefficients), len(other.coefficients))

        newCoefficients = []

        for coeffIdx in range(maxLen):
            selfCoeffLen = len(self.coefficients)
            otherCoeffLen = len(other.coefficients)

            if coeffIdx < selfCoeffLen and coeffIdx < otherCoeffLen:
                newCoefficients.append(
                    self.coefficients[coeffIdx] + other.coefficients[coeffIdx]
                )
            elif coeffIdx < selfCoeffLen:
                newCoefficients.append(self.coefficients[coeffIdx])
            else:
                newCoefficients.append(other.coefficients[coeffIdx])

        result = Polynomial(newCoefficients)

        result.normalize()

        return result

    def __sub__(self, other: "Polynomial") -> "Polynomial":
        if len(self.coefficients) == 0 and len(other.coefficients) == 0:
            return Polynomial([])

        maxLen = max(len(self.coefficients), len(other.coefficients))

        neutralElement = (
            self.coefficients[0]
            if len(self.coefficients) > 0
            else other.coefficients[0]
        ).neutral()

        newCoefficients = [neutralElement] * maxLen

        for coeffIdx in range(maxLen):
            selfCoeffLen = len(self.coefficients)
            otherCoeffLen = len(other.coefficients)

            if coeffIdx < selfCoeffLen and coeffIdx < otherCoeffLen:
                newCoefficients[coeffIdx] = (
                    self.coefficients[coeffIdx] - other.coefficients[coeffIdx]
                )
            elif coeffIdx < selfCoeffLen:
                newCoefficients[coeffIdx] = self.coefficients[coeffIdx]
            else:
                newCoefficients[coeffIdx] = (
                    newCoefficients[coeffIdx] - other.coefficients[coeffIdx]
                )

        result = Polynomial(newCoefficients)

        result.normalize()

        return result

    def __truediv__(self, other: "Polynomial") -> "Polynomial":
        if len(self.coefficients) == 0 and len(other.coefficients) == 0:
            return Polynomial([])

        neutralElement = (
            self.coefficients[0]
            if len(self.coefficients) > 0
            else other.coefficients[0]
        ).neutral()

        quotientLen = (
            len(self.coefficients) - len(other.coefficients)
            if len(self.coefficients) > len(other.coefficients)
            else 0
        )

        remainder = Polynomial(self.coefficients)
        quotient = Polynomial([neutralElement] * quotientLen)

        while len(remainder.coefficients) >= len(other.coefficients):
            coeff = remainder.coefficients[-1] / other.coefficients[-1]

            newQuotientCoefficients = [neutralElement] * (
                len(remainder.coefficients) - len(other.coefficients) + 1
            )

            newQuotientCoefficients[-1] = coeff

            newQuotient = Polynomial(newQuotientCoefficients)

            quotient = quotient + newQuotient

            remainder = remainder - (newQuotient * other)

            remainder.normalize()

        quotient.normalize()

        return quotient

    def __mod__(self, other: "Polynomial") -> "Polynomial":
        if len(self.coefficients) == 0 and len(other.coefficients) == 0:
            return Polynomial([])

        neutralElement = (
            self.coefficients[0]
            if len(self.coefficients) > 0
            else other.coefficients[0]
        ).neutral()

        quotientLen = (
            len(self.coefficients) - len(other.coefficients)
            if len(self.coefficients) > len(other.coefficients)
            else 0
        )

        remainder = Polynomial(self.coefficients)
        quotient = Polynomial([neutralElement] * quotientLen)

        while len(remainder.coefficients) >= len(other.coefficients):
            coeff = remainder.coefficients[-1] / other.coefficients[-1]

            newQuotientCoefficients = [neutralElement] * (
                len(remainder.coefficients) - len(other.coefficients) + 1
            )

            newQuotientCoefficients[-1] = coeff

            newQuotient = Polynomial(newQuotientCoefficients)

            quotient = quotient + newQuotient

            remainder = remainder - (newQuotient * other)

            remainder.normalize()

        remainder.normalize()

        return remainder

    def __mul__(self, other: "Polynomial") -> "Polynomial":
        resultDegree = len(self.coefficients) + len(other.coefficients) - 1

        if resultDegree < 0:
            resultDegree = 0

        neutralElement = (
            self.coefficients[0]
            if len(self.coefficients) > 0
            else other.coefficients[0]
        ).neutral()

        newCoefficients = [neutralElement] * resultDegree

        for selfCoeffIdx in range(len(self.coefficients)):
            for otherCoeffIdx in range(len(other.coefficients)):
                newCoefficients[selfCoeffIdx + otherCoeffIdx] = (
                    newCoefficients[selfCoeffIdx + otherCoeffIdx]
                    + self.coefficients[selfCoeffIdx]
                    * other.coefficients[otherCoeffIdx]
                )

        result = Polynomial(newCoefficients)

        result.normalize()

        return result

    def __lt__(self, other: "Polynomial") -> bool:
        if len(self.coefficients) < len(other.coefficients):
            return True
        elif len(self.coefficients) > len(other.coefficients):
            return False
        else:
            for coeffIdx in reversed(range(len(self.coefficients))):
                selfCoeff = self.coefficients[coeffIdx]
                otherCoeff = other.coefficients[coeffIdx]

                if selfCoeff < otherCoeff:
                    return True
                elif selfCoeff < otherCoeff:
                    return False

            return False

    def __gt__(self, other: "Polynomial") -> bool:
        if len(self.coefficients) > len(other.coefficients):
            return True
        elif len(self.coefficients) < len(other.coefficients):
            return False
        else:
            for coeffIdx in reversed(range(len(self.coefficients))):
                selfCoeff = self.coefficients[coeffIdx]
                otherCoeff = other.coefficients[coeffIdx]

                if selfCoeff > otherCoeff:
                    return True
                elif selfCoeff < otherCoeff:
                    return False

            return False

    def __getitem__(self, idx: int) -> T:
        if idx < 0 or idx >= len(self.coefficients):
            raise NoCoeffException
        else:
            return self.coefficients[idx]

    def __call__(self, x: T) -> "PolynomialType":
        result = self.coefficients[0].neutral()

        for coeffIdx in range(len(self.coefficients)):
            result = result + self.coefficients[coeffIdx] * (x**coeffIdx)

        return result

    def __str__(self) -> str:
        if len(self.coefficients) == 0:
            return "0"
        else:
            neutralElement = self.coefficients[0].neutral()
            output = ""

            for coeffIdx in reversed(range(len(self.coefficients))):
                if not (self.coefficients[coeffIdx] == neutralElement):
                    if coeffIdx < len(self.coefficients) - 1:
                        output += " + "

                    output += str(self.coefficients[coeffIdx])

                    if coeffIdx > 0:
                        output += "x^{}".format(coeffIdx)

            return output


class PolynomialException(Exception):
    pass


class NoCoeffException(PolynomialException):
    pass
