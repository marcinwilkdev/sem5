%{
  #include <stdio.h>

  int yywrap(void);
  int yylex(void);

  size_t linesCount = 0;
  size_t wordsCount = 0;
%}

%%

^[ \t]*\n
^[ \t]+
[ \t]+$

[ \t]+ { ++wordsCount; printf(" "); }
\n     { ++wordsCount; ++linesCount; printf("\n"); }

[ \t]+[^\n]

%%


int yywrap(void) {
  /* printf("Lines count: %zu, words count: %zu\n", linesCount, wordsCount); */
  return 1;
}


int main(const int argc, const char* argv[const argc + 1]) {
  if (argc >= 2) {
    yyin = fopen(argv[1], "r");
  }

  return yylex();
}
