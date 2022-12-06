from gf import GF, GFNoInverseException, GF_MAX_VALUE
from gf2 import GF2, GF2NoInverseException, GF2_MAX_VALUE


class ParseState:
    value: int
    text: str
    isError: bool

    def __init__(self, text: str):
        self.value = int(text)
        self.text = ""
        self.isError = False

    def setNeg(self) -> "ParseState":
        if not self.isError:
            self.value = GF(-self.value).value()
            self.text = str(self.value) + " "

        return self

    def setNum(self) -> "ParseState":
        if not self.isError:
            self.value = GF(self.value).value()
            self.text = str(self.value) + " "

        return self

    def add(self, other: "ParseState") -> "ParseState":
        if (not self.isError) and other.isError:
            self.text = other.text
            self.isError = True

        if not self.isError:
            self.value = (GF(self.value) + GF(other.value)).value()
            self.text += other.text + "+ "

        return self

    def sub(self, other: "ParseState") -> "ParseState":
        if (not self.isError) and other.isError:
            self.text = other.text
            self.isError = True

        if not self.isError:
            self.value = (GF(self.value) - GF(other.value)).value()
            self.text += other.text + "- "

        return self

    def mul(self, other: "ParseState") -> "ParseState":
        if (not self.isError) and other.isError:
            self.text = other.text
            self.isError = True

        if not self.isError:
            self.value = (GF(self.value) * GF(other.value)).value()
            self.text += other.text + "* "

        return self

    def div(self, other: "ParseState") -> "ParseState":
        if (not self.isError) and other.isError:
            self.text = other.text
            self.isError = True

        if not self.isError:
            try:
                self.value = (GF(self.value) / GF(other.value)).value()
                self.text += other.text + "/ "
            except GFNoInverseException:
                self.text = (
                    str(GF(other.value).value())
                    + " nie jest odwracalne modulo "
                    + str(GF_MAX_VALUE)
                )
                self.isError = True

        return self

    def neg(self) -> "ParseState":
        if not self.isError:
            self.value = GF(-self.value).value()
            self.text += "~ "

        return self

    def exp(self, other: "ParseState") -> "ParseState":
        if (not self.isError) and other.isError:
            self.text = other.text
            self.isError = True

        if not self.isError:
            self.value = (GF(self.value) ** GF(other.value)).value()
            self.text += other.text + "^ "

        return self

    def setNegExp(self) -> "ParseState":
        if not self.isError:
            self.value = GF2(-self.value).value()
            self.text = str(self.value) + " "

        return self

    def setNumExp(self) -> "ParseState":
        if not self.isError:
            self.value = GF2(self.value).value()
            self.text = str(self.value) + " "

        return self

    def addExp(self, other: "ParseState") -> "ParseState":
        if (not self.isError) and other.isError:
            self.text = other.text
            self.isError = True

        if not self.isError:
            self.value = (GF2(self.value) + GF2(other.value)).value()
            self.text += other.text + "+ "

        return self

    def subExp(self, other: "ParseState") -> "ParseState":
        if (not self.isError) and other.isError:
            self.text = other.text
            self.isError = True

        if not self.isError:
            self.value = (GF2(self.value) - GF2(other.value)).value()
            self.text += other.text + "- "

        return self

    def mulExp(self, other: "ParseState") -> "ParseState":
        if (not self.isError) and other.isError:
            self.text = other.text
            self.isError = True

        if not self.isError:
            self.value = (GF2(self.value) * GF2(other.value)).value()
            self.text += other.text + "* "

        return self

    def divExp(self, other: "ParseState") -> "ParseState":
        if (not self.isError) and other.isError:
            self.text = other.text
            self.isError = True

        if not self.isError:
            try:
                self.value = (GF2(self.value) / GF2(other.value)).value()
                self.text += other.text + "/ "
            except GF2NoInverseException:
                self.text = (
                    str(GF2(other.value).value())
                    + " nie jest odwracalne modulo "
                    + str(GF2_MAX_VALUE)
                )
                self.isError = True

        return self

    def negExp(self) -> "ParseState":
        if not self.isError:
            self.value = GF2(-self.value).value()
            self.text += "~ "

        return self

    def __str__(self):
        if self.isError:
            return "> {}".format(self.text)
        else:
            return "{}\n= {}".format(self.text, self.value)
