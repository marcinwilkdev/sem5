%{
  #include <stdio.h>

  int yywrap(void);
  int yylex(void);
%}

%%

["][^"\n]*["]        printf("%s", yytext);
['][^'\n]*[']        printf("%s", yytext);
["""][^(""")]*["""]  printf("%s", yytext);

#.*
^[ \t]+#.*\n

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
