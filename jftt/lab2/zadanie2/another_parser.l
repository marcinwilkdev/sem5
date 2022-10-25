%{
  #include <stdio.h>

  int yywrap(void);
  int yylex(void);

  size_t oneCount = 0;
  size_t digitCount = 0;
%}

%%

1+ ++oneCount;
[[:digit:]]+ ++digitCount;

%%

int yywrap(void) {
  printf("%zu %zu\n", oneCount, digitCount);
  return 1;
}

int main(void) {
  return yylex();
}
