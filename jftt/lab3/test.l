%option noyywrap

%{
  #include "test_y.h"

  int yylex(void);
%}

%%

[ \t]+ ;
^#(\\\n|.)*\n ;

\-[0-9]+         { yylval = (atoi(yytext) % 1234577) + 1234577; return NUM; }
[0-9]+         { yylval = atoi(yytext) % 1234577; return NUM; }
\-             { return SUB; }
\+             { return ADD; }
\*             { return MUL; }
\/             { return DIV; }
\^             { return EXP; }
\(             { return LPAR; }
\)             { return RPAR; }

\\\n ;
\n             { return END; }

.              { return ERROR; }

%%
