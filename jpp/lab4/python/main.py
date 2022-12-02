from polynomial import Polynomial as P
from doubleWrapper import DoubleWrapper as DW
from gf import GF as GF


def main():
    firstPolynomial = P([DW(-1.0), DW(2.0), DW(0.0), DW(1.0)])
    secondPolynomial = P([DW(-1.0), DW(1.0)])

    print(firstPolynomial + secondPolynomial - secondPolynomial)
    print(firstPolynomial * secondPolynomial / secondPolynomial)
    print(firstPolynomial[0])
    print(firstPolynomial(DW(2.0)))

    thirdPolynomial = P([GF(1), GF(1), GF(0), GF(1)])
    fourthPolynomial = P([GF(1), GF(1)])

    print(thirdPolynomial + fourthPolynomial - fourthPolynomial)
    print(thirdPolynomial * fourthPolynomial / fourthPolynomial)
    print(thirdPolynomial[0])
    print(thirdPolynomial(GF(1)))


if __name__ == "__main__":
    main()
