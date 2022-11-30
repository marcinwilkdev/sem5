from abc import ABC, abstractmethod


class PolynomialType(ABC):
    @abstractmethod
    def neutral(self) -> "PolynomialType":
        pass

    @abstractmethod
    def __add__(self, other: "PolynomialType") -> "PolynomialType":
        pass

    @abstractmethod
    def __sub__(self, other: "PolynomialType") -> "PolynomialType":
        pass

    @abstractmethod
    def __mul__(self, other: "PolynomialType") -> "PolynomialType":
        pass

    @abstractmethod
    def __truediv__(self, other: "PolynomialType") -> "PolynomialType":
        pass

    @abstractmethod
    def __pow__(self, other: int) -> "PolynomialType":
        pass

    @abstractmethod
    def __gt__(self, other: "PolynomialType") -> "PolynomialType":
        pass

    @abstractmethod
    def __lt__(self, other: "PolynomialType") -> "PolynomialType":
        pass

    @abstractmethod
    def __str__(self, other: "PolynomialType") -> "PolynomialType":
        pass

    @abstractmethod
    def __eq__(self, other: "PolynomialType") -> "PolynomialType":
        pass
