import polynomial
import doubleWrapper
import gf


DW = doubleWrapper.DoubleWrapper


def main():
    firstPolynomial = polynomial.Polynomial([DW(-1.0), DW(2.0), DW(0.0), DW(1.0)])
    secondPolynomial = polynomial.Polynomial([DW(-1.0), DW(1.0)])

    print(firstPolynomial + secondPolynomial - secondPolynomial)
    print(firstPolynomial * secondPolynomial / secondPolynomial)
    print(firstPolynomial[0])
    print(firstPolynomial(DW(2.0)))

    thirdPolynomial = polynomial.Polynomial([gf.GF(1), gf.GF(1), gf.GF(0), gf.GF(1)])
    fourthPolynomial = polynomial.Polynomial([gf.GF(1), gf.GF(1)])

    print(thirdPolynomial + fourthPolynomial - fourthPolynomial)
    print(thirdPolynomial * fourthPolynomial / fourthPolynomial)
    print(thirdPolynomial[0])
    print(thirdPolynomial(gf.GF(1)))


if __name__ == "__main__":
    main()
