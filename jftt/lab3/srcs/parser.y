%{
  #include <stdio.h>
  #include "../hdrs/project.hpp"

  int yylex(void);
  int yyerror(char*);

  using GF = gf::GF<1234577>;
  using GF2 = gf::GF<1234576>;
%}

%define api.value.type {long}

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
    | exp END   { std::cout << "\n= " << $1 << "\n\n"; }
    | error END { std::cout << "\n> Błąd składni.\n\n"; }
    | ERROR END { std::cout << "\n> Błąd składni.\n\n"; }
;

exp:
    SUB NUM %prec NEG   { std::cout << GF(-$2) << ' '; $$ = GF(-$2); }
    | NUM               { std::cout << GF( $1) << ' '; $$ = GF( $1); }
    | exp ADD exp       { std::cout << "+ "; $$ = GF($1) + GF($3); }
    | exp SUB exp       { std::cout << "- "; $$ = GF($1) - GF($3); }
    | exp MUL exp       { std::cout << "* "; $$ = GF($1) * GF($3); }
    | exp DIV exp       { std::cout << "/ "; try {$$ = GF($1) / GF($3);} catch (gf::GFNoInverseException) {std::cout << '\n' << GF($3) << " nie jest odwracalne modulo " << GF::MAX_VALUE; } }
    | SUB exp %prec NEG { $$ = GF(-$2); }
    | exp EXP expexp    { std::cout << "^ "; $$ = GF($1) ^ GF($3);}
    | LPAR exp RPAR     { $$ = GF($2); }
;

expexp:
    SUB NUM %prec NEG      { std::cout << GF2(-$2) << ' '; $$ = GF2(-$2); }
    | NUM                  { std::cout << GF2( $1) << ' '; $$ = GF2( $1); }
    | expexp ADD expexp    { std::cout << "+ "; $$ = GF2($1) + GF2($3); }
    | expexp SUB expexp    { std::cout << "- "; $$ = GF2($1) - GF2($3); }
    | expexp MUL expexp    { std::cout << "* "; $$ = GF2($1) * GF2($3); }
    | expexp DIV expexp    { std::cout << "/ "; try {$$ = GF2($1) / GF2($3);} catch (gf::GFNoInverseException) {std::cout << '\n' << GF2($1) << " nie jest odwracalne modulo " << GF2::MAX_VALUE; } }
    | SUB expexp %prec NEG { $$ = GF2(-$2); }
    | LPAR expexp RPAR     { $$ = GF2($2); }
;

%%

int yyerror(char *const s)
{
   /* printf("%s\n",s); */
    return 0;
}
