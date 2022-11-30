import polynomial


DW = polynomial.DoubleWrapper


def main():
    myPol = polynomial.Polynomial([DW(-1.0), DW(2.0), DW(0.0), DW(1.0)])

    print(str(myPol))


if __name__ == "__main__":
    main()
