%option noyywrap

%{
  #include "parser.hpp"
  #include <sstream>
%}

%%

[ \t]+             ;
\[[^\]]*\]         ;

PROCEDURE          { return PROCEDURE; }
IS                 { return IS; }
VAR                { return VAR; }
BEGIN              { return BEG; }
END                { return END; }
PROGRAM            { return PROGRAM; }
IF                 { return IF; }
THEN               { return THEN; }
ELSE               { return ELSE; }
ENDIF              { return ENDIF; }
WHILE              { return WHILE; }
DO                 { return DO; }
ENDWHILE           { return ENDWHILE; }
REPEAT             { return REPEAT; }
UNTIL              { return UNTIL; }
READ               { return READ; }
WRITE              { return WRITE; }
"("                { return LPAR; }
")"                { return RPAR; }
","                { return COMMA; }
";"                { return SEMICOLON; }
":="               { return ASSIGN; }

"+"                { return ADD; }
"-"                { return SUB; }
"*"                { return MUL; }
"/"                { return DIV; }
"%"                { return MOD; }

"="                { return EQ; }
"!="               { return NEQ; }
">"                { return GT; }
"<"                { return LT; }
">="               { return GE; }
"<="               { return LE; }

[0-9]+             { yylval = compiler::Variable::fromValue(yytext); return NUM; }
[_a-z]+            { yylval = compiler::Variable::fromId(yytext); return ID; }

.                  { return ERROR; }

%%
