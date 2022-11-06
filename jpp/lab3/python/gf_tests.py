from gf import GF, GFException, GFNegativeException, GFTooBigException


def GFCreationTest():
    try:
        _ = GF(-1)
        assert False
    except GFNegativeException:
        assert True
    except GFException:
        assert False

    try:
        _ = GF(1234567891)
        assert False
    except GFTooBigException:
        assert True
    except GFException:
        assert False

    try:
        _ = GF(50)
        assert True
    except GFException:
        assert False


def GFAdditionTest():
    try:
        gf1 = GF(50)
        gf2 = GF(50)

        gf1 = gf1 + gf2

        assert gf1 == GF(100)

        gf1 = GF(1234567890)
        gf2 = GF(1)

        gf1 += gf2

        assert gf1 == GF(0)

        gf1 = GF(1234567890)
        gf2 = GF(1)
        gf3 = GF(10)

        gf1 += gf2 + gf3

        assert gf1 == GF(10)
    except GFException:
        assert False


def GFSubtractionTest():
    try:
        gf1 = GF(51)
        gf2 = GF(50)

        gf1 -= gf2

        assert gf1 == GF(1)

        gf1 = GF(50)
        gf2 = GF(51)

        gf1 -= gf2

        assert gf1 == GF(1234567890)

        gf1 = GF(50)
        gf2 = GF(51)
        gf3 = GF(10)

        gf1 -= gf2
        gf1 -= gf3

        assert gf1 == GF(1234567880)
    except GFException:
        assert False


def GFMultiplicationTest():
    try:
        gf1 = GF(50)
        gf2 = GF(50)

        gf1 *= gf2

        assert gf1 == GF(2500)

        gf1 = GF(1234567890)
        gf2 = GF(2)

        gf1 *= gf2

        assert gf1 == GF(1234567889)

        gf1 = GF(1234567890)
        gf2 = GF(2)
        gf3 = GF(2)

        gf1 *= gf2
        gf1 *= gf3

        assert gf1 == GF(1234567887)
    except GFException:
        assert False


def GFDivisionTest():
    try:
        gf1 = GF(100)
        gf2 = GF(50)

        gf1 //= gf2

        assert gf1 == GF(2)

        gf1 = GF(100)
        gf2 = GF(3)

        gf1 //= gf2

        assert gf1 == GF(33)

        gf1 = GF(100)
        gf2 = GF(3)
        gf3 = GF(3)

        gf1 //= gf2
        gf1 //= gf3

        assert gf1 == GF(11)
    except GFException:
        assert False


def main():
    GFCreationTest()
    GFAdditionTest()
    GFSubtractionTest()
    GFMultiplicationTest()
    GFDivisionTest()
    print("All tests passed")


if __name__ == "__main__":
    main()
