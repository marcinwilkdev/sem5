%{
  #include <stdio.h>

  int yywrap(void);
  int yylex(void);
%}

%%

\"[^"\n]*\"               |
\<[^"\n]*\>               |
\/{3}.*                   |
\/{2}!.*                  |
"/**"("*"[^/]|[^*])*"*/"  |
"/*!"("*"[^/]|[^*])*"*/"  printf("%s", yytext);


"/*"("*"[^/]|[^*])*"*/"
\/{2}.*

%%


int yywrap(void) {
  return 1;
}


int main(const int argc, const char* argv[const argc + 1]) {
  if (argc >= 2) {
    yyin = fopen(argv[1], "r");
  }

  return yylex();
}
