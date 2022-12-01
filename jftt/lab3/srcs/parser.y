%{
  #include<stdio.h>

  int yylex(void);
  int yyerror(char*);
%}

%token NUM

%left ADD SUB
%left MUL DIV

%precedence NEG

%right EXP

%token LPAR RPAR

%token END

%token ERROR

%%

input:
     %empty
    | input line
;

line:
    END
    | exp END { printf("\n= %d\n", $1); }
    | error END { printf("\n> Błąd składni.\n"); }
    | ERROR END { printf("\n> Błąd składni.\n"); }
;

exp:
    SUB NUM %prec NEG   { printf("%d ", (-$$ % 1234577) + 1234577); }
    | NUM               { printf("%d ", $$); }
    | exp ADD exp       { printf("+ "); $$ = ($1 + $3) % 1234577; }
    | exp SUB exp       { printf("- "); $$ = ($1 - $3) % 1234577; }
    | exp MUL exp       { printf("* "); $$ = ($1 * $3) % 1234577; }
    | exp DIV exp       { printf("/ "); $$ = ($1 / $3) % 1234577; }
    | SUB exp %prec NEG { $$ = 1234577 - $2; }
    | exp EXP exp       { printf("^ "); $$ = $1 * $3; }
    | LPAR exp RPAR     { $$ = $2; }
;

%%

int yyerror(char *const s)
{
/*    printf("%s\n",s);	*/
    return 0;
}
