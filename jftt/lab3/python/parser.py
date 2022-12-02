from sly import Parser
from lexer import CalcLexer

from parseState import ParseState


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
        print(str(p.exp) + '\n')

    @_("error END")
    def line(self, p):
        print("> Błąd składni\n")

    @_("ERROR END")
    def line(self, p):
        print("> Błąd składni\n")

    @_("SUB NUM %prec NEG")
    def exp(self, p):
        return p.NUM.setNeg()

    @_("NUM")
    def exp(self, p):
        return p.NUM.setNum()

    @_("exp ADD exp")
    def exp(self, p):
        return p.exp0.add(p.exp1)

    @_("exp SUB exp")
    def exp(self, p):
        return p.exp0.sub(p.exp1)

    @_("exp MUL exp")
    def exp(self, p):
        return p.exp0.mul(p.exp1)

    @_("exp DIV exp")
    def exp(self, p):
        return p.exp0.div(p.exp1)

    @_("SUB exp %prec NEG")
    def exp(self, p):
        return p.exp.neg()

    @_("exp EXP expexp")
    def exp(self, p):
        return p.exp.exp(p.expexp)

    @_("LPAR exp RPAR")
    def exp(self, p):
        return p.exp

    @_("SUB NUM %prec NEG")
    def expexp(self, p):
        return p.NUM.setNegExp()

    @_("NUM")
    def expexp(self, p):
        return p.NUM.setNumExp()

    @_("expexp ADD expexp")
    def expexp(self, p):
        return p.expexp0.addExp(p.expexp1)

    @_("expexp SUB expexp")
    def expexp(self, p):
        return p.expexp0.subExp(p.expexp1)

    @_("expexp MUL expexp")
    def expexp(self, p):
        return p.expexp0.mulExp(p.expexp1)

    @_("expexp DIV expexp")
    def expexp(self, p):
        return p.expexp0.divExp(p.expexp1)

    @_("SUB expexp %prec NEG")
    def expexp(self, p):
        return p.expexp.negExp()

    @_("LPAR expexp RPAR")
    def expexp(self, p):
        return p.expexp

    def error(self, p):
        pass


if __name__ == "__main__":
    lexer = CalcLexer()
    parser = CalcParser()

    while True:
        try:
            text = input()
            result = parser.parse(lexer.tokenize(text + "\n"))
        except EOFError:
            break
