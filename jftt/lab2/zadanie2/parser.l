%{
  #include <stdio.h>

  int yywrap(void);
  int yylex(void);
%}

%%

["][^"]*["]        printf("%s", yytext);
["""][^"]*["""]    printf("%s", yytext);
['][^']*[']        printf("%s", yytext);
^[ \t]+#.*$
#.*$               printf("\n");

%%

int yywrap(void) {
  return 1;
}

int main(void) {
  return yylex();
}
