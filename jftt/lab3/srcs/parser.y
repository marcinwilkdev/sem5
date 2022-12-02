%code requires {
  #include <iostream>
  #include "../hdrs/parseState.hpp"
}

%{
  #include <sstream>
  #include "../hdrs/gf.hpp"

  int yylex(void);
  int yyerror(char*);

  using GF = gf::GF<1234577>;
  using GF2 = gf::GF<1234576>;
%}

%define api.value.type {parseState::ParseState}

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
    | exp END   { std::cout << $1 << '\n'; }
    | error END { std::cout << "> Błąd składni.\n\n"; }
    | ERROR END { std::cout << "> Błąd składni.\n\n"; }
;

exp:
    SUB NUM %prec NEG   { $$ = $2.setNeg(); }
    | NUM               { $$ = $1.setNum(); }
    | exp ADD exp       { $$ = $1.add($3); }
    | exp SUB exp       { $$ = $1.sub($3); }
    | exp MUL exp       { $$ = $1.mul($3); }
    | exp DIV exp       { $$ = $1.div($3); }
    | SUB exp %prec NEG { $$ = $2.neg(); }
    | exp EXP expexp    { $$ = $1.exp($3); }
    | LPAR exp RPAR     { $$ = $2; }
;

expexp:
    SUB NUM %prec NEG      { $$ = $2.setNegExp(); }
    | NUM                  { $$ = $1.setNumExp(); }
    | expexp ADD expexp    { $$ = $1.addExp($3); }
    | expexp SUB expexp    { $$ = $1.subExp($3); }
    | expexp MUL expexp    { $$ = $1.mulExp($3); }
    | expexp DIV expexp    { $$ = $1.divExp($3); }
    | SUB expexp %prec NEG { $$ = $2.negExp(); }
    | LPAR expexp RPAR     { $$ = $2; }
;

%%

int yyerror(char *const s)
{
    return 0;
}
