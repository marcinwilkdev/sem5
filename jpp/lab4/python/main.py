import polynomial
import doubleWrapper


DW = doubleWrapper.DoubleWrapper


def main():
    firstPolynomial = polynomial.Polynomial([DW(-1.0), DW(2.0), DW(0.0), DW(1.0)])
    secondPolynomial = polynomial.Polynomial([DW(-1.0), DW(1.0)])

    print(firstPolynomial + secondPolynomial - secondPolynomial)
    print(firstPolynomial * secondPolynomial / secondPolynomial)
    print(firstPolynomial[0])
    print(firstPolynomial(DW(2.0)))


if __name__ == "__main__":
    main()
