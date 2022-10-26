%{
  #include <stdlib.h>
  #include <stdio.h>
  #include <tgmath.h>
  #include <stdbool.h>

  int yywrap(void);
  int yylex(void);

  #define STACK_SIZE 4096

  int stack[STACK_SIZE];
  size_t stackLen = 0;
  bool errorState = false;

  void getNumber(int number);

  bool checkTooFewNumbers(void);
  bool checkDivisionByZero(void);

  void getAddition(void);
  void getSubtraction(void);
  void getMultiplication(void);
  void getDivision(void);
  void getPower(void);
  void getModulus(void);
  void getNewLine(void);

  void wrongSymbol(const char* symbol);
%}

%%

"-"?[0-9]+   getNumber(atoi(yytext));
"+"          getAddition();
"-"          getSubtraction();
"*"          getMultiplication();
"/"          getDivision();
"^"          getPower();
"%"          getModulus();
\n           getNewLine();
[^ ]         wrongSymbol(yytext);

%%

void getNumber(int number)
{
  if (errorState)
  {
    return;
  }

  if (stackLen == STACK_SIZE - 1)
  {
    fprintf(stderr, "Błąd: przekroczono rozmiar stosu");
    errorState = true;
    return;
  }

  stack[stackLen] = number;
  ++stackLen;
}

bool checkTooFewNumbers(void)
{
  if (stackLen < 2)
  {
    fprintf(stderr, "Błąd: za mała liczba argumentów");
    errorState = true;
    return true;
  }

  return false;
}

bool checkDivisionByZero(void)
{
  if (stackLen > 0 && stack[stackLen - 1] == 0)
  {
    fprintf(stderr, "Błąd: dzielenie przez 0");
    errorState = true;
    return true;
  }

  return false;
}

void getAddition(void)
{
  if (errorState || checkTooFewNumbers())
  {
    return;
  }

  stack[stackLen - 2] = stack[stackLen - 2] + stack[stackLen - 1];
  --stackLen;
}

void getSubtraction(void)
{
  if (errorState || checkTooFewNumbers())
  {
    return;
  }

  stack[stackLen - 2] = stack[stackLen - 2] - stack[stackLen - 1];
  --stackLen;
}

void getMultiplication(void)
{
  if (errorState || checkTooFewNumbers())
  {
    return;
  }

  stack[stackLen - 2] = stack[stackLen - 2] * stack[stackLen - 1];
  --stackLen;
}

void getDivision(void)
{
  if (errorState || checkTooFewNumbers() || checkDivisionByZero())
  {
    return;
  }

  stack[stackLen - 2] = stack[stackLen - 2] / stack[stackLen - 1];
  --stackLen;
}

void getPower(void)
{
  if (errorState || checkTooFewNumbers())
  {
    return;
  }

  stack[stackLen - 2] = (int) pow(stack[stackLen - 2], stack[stackLen - 1]);
  --stackLen;
}

void getModulus(void)
{
  if (errorState || checkTooFewNumbers() || checkDivisionByZero())
  {
    return;
  }

  stack[stackLen - 2] = stack[stackLen - 2] % stack[stackLen - 1];
  --stackLen;
}

void getNewLine(void)
{
  if (!errorState && stackLen > 1)
  {
    fprintf(stderr, "Błąd: za mała liczba operatorów");
  }
  else if (!errorState)
  {
    printf("\r%d", stack[0]);
  }

  errorState = false;
  stackLen = 0;

  printf("\n");
}

void wrongSymbol(const char* const symbol)
{
  if (errorState)
  {
    return;
  }

  fprintf(stderr, "Błąd: zły symbol \"%s\"", symbol);
  errorState = true;
}

int yywrap(void) {
  return 1;
}

int main(const int argc, const char* argv[const argc + 1]) {
  if (argc >= 2) {
    yyin = fopen(argv[1], "r");
  }

  return yylex();
}
