%{
  #define YYSTYPE int

  #include<stdio.h>

  extern int yylineno;  // z lex-a
  int yylex(void);
  int yyerror(char*);
%}

%token VAL
%token AND
%token OR
%token NOT
%token LNAW
%token PNAW
%token END
%token ERROR

%%

input:
    | input line
;

line: expe END	{ $$ = $1; printf("\nLinia %d = %s\n", yylineno - 1, $$ ? "true" : "false"); }
    | error END	{ printf("\nBłąd składni w linii %d!\n", yylineno -1 ); }
;

expe: expt		      { $$ = $1; }
    | expe OR expt	{ $$ = $1 || $3; printf("or "); }
;

expt: expf		      { $$ = $1; }
    | expt AND expf	{ $$ = $1 && $3; printf("and "); }
;

expf: VAL		          { $$ = $1;  printf("%s ", $$ ? "true" : "false"); }
    | NOT expf		    { $$ = !$2; printf("not "); }
    | LNAW expe PNAW	{ $$ = $2; }
;

%%

int yyerror(char *const s)
{
/*    printf("%s\n",s);	*/
    return 0;
}

int main(void)
{
    yyparse();
    printf("Przetworzono linii: %d\n", yylineno - 1);
    return 0;
}
