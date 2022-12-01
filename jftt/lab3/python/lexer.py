from sly import Lexer


class CalcLexer(Lexer):
    tokens = {NUM, ADD, SUB, MUL, DIV, EXP, LPAR, RPAR, END, ERROR}

    ignore = " \t"

    ignore_comment = r"^#(\\\n|.)*\n"
    ignore_newline = r"\\\n"

    NUM = r"\d+"
    ADD = r"\+"
    SUB = r"-"
    MUL = r"\*"
    DIV = r"/"
    EXP = r"\^"
    LPAR = r"\("
    RPAR = r"\)"
    END = r"\n"
    ERROR = r"."

    @_(r'\d+')
    def NUM(self, t):
        t.value = int(t.value)
        return t


if __name__ == "__main__":
    lexer = CalcLexer()

    while True:
        try:
            text = input("calc > ")
            for tok in lexer.tokenize(text + '\n'):
                print(tok)
        except EOFError:
            break
