from sly import Parser
from lexer import CalcLexer

from gf import GF
from gf2 import GF2


class CalcParser(Parser):
    tokens = CalcLexer.tokens

    precedence = (
        ("nonassoc", NUM),
        ("left", ADD, SUB),
        ("left", MUL, DIV),
        ("right", NEG),
        ("right", EXP),
        ("nonassoc", LPAR, RPAR),
        ("nonassoc", END),
        ("nonassoc", ERROR),
    )

    @_("")
    def input(self, p):
        pass

    @_("input line")
    def input(self, p):
        pass

    @_("END")
    def line(self, p):
        pass

    @_("exp END")
    def line(self, p):
        print("\n= ", p.exp)

    @_("error END")
    def line(self, p):
        print("\nBłąd składni")

    @_("ERROR END")
    def line(self, p):
        print("\nBłąd składni")

    @_("SUB NUM %prec NEG")
    def exp(self, p):
        print(GF(-p.NUM).value(), end=" ")
        return GF(-p.NUM).value()

    @_("NUM")
    def exp(self, p):
        print(GF(p.NUM).value(), end=" ")
        return GF(p.NUM).value()

    @_("exp ADD exp")
    def exp(self, p):
        print("+ ", end=" ")
        return GF(p.exp0).value() + GF(p.exp1).value()

    @_("exp SUB exp")
    def exp(self, p):
        print("- ", end=" ")
        return GF(p.exp0 - p.exp1).value()

    @_("exp MUL exp")
    def exp(self, p):
        print("* ", end=" ")
        return GF(p.exp0 * p.exp1).value()

    @_("exp DIV exp")
    def exp(self, p):
        print("/ ", end=" ")
        return GF(p.exp0 / p.exp1).value()

    @_("SUB exp %prec NEG")
    def exp(self, p):
        return GF(-p.exp).value()

    @_("exp EXP expexp")
    def exp(self, p):
        print("^ ", end=" ")
        return GF(p.exp).value() ** GF(p.expexp).value()

    @_("LPAR exp RPAR")
    def exp(self, p):
        return GF(p.exp).value()

    @_("SUB NUM %prec NEG")
    def expexp(self, p):
        print(GF2(-p.NUM), end=" ")
        return GF2(-p.NUM)

    @_("NUM")
    def expexp(self, p):
        print(GF2(p.NUM), end=" ")
        return GF2(p.NUM)

    @_("expexp ADD expexp")
    def expexp(self, p):
        print("+ ", end=" ")
        return GF2(p.expexp0) + GF2(p.expexp1)

    @_("expexp SUB expexp")
    def expexp(self, p):
        print("- ", end=" ")
        return GF2(p.expexp0) - GF2(p.expexp1)

    @_("expexp MUL expexp")
    def expexp(self, p):
        print("* ", end=" ")
        return GF2(p.expexp0) * GF2(p.expexp1)

    @_("expexp DIV expexp")
    def expexp(self, p):
        print("/ ", end=" ")
        return GF2(p.expexp0) / GF2(p.expexp1)

    @_("SUB expexp %prec NEG")
    def expexp(self, p):
        return GF2(-p.expexp)

    @_("LPAR expexp RPAR")
    def expexp(self, p):
        return GF2(p.expexp)

    def error(self, p):
        pass


if __name__ == "__main__":
    lexer = CalcLexer()
    parser = CalcParser()

    while True:
        try:
            text = input("calc > ")
            result = parser.parse(lexer.tokenize(text + "\n"))
        except EOFError:
            break
