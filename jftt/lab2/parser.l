%{
  #include <stdio.h>

  int yywrap(void);
  int yylex(void);

  size_t linesCount = 0;
  size_t wordsCount = 0;
%}

%%

^[ \t]+
[ \t]+$
^\n

[ \t]+ { ++wordsCount; printf(" "); }
\n     { ++wordsCount; ++linesCount; printf("\n"); }

%%

int yywrap(void) {
  printf("Lines count: %zu, words count: %zu\n", linesCount, wordsCount);
  return 1;
}

int main(void) {
  return yylex();
}
