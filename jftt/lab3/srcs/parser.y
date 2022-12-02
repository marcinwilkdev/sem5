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

%define api.value.type {struct { long value; std::string text; }}

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
    | exp END   { std::cout << $1.text << "\n= " << $1.value << "\n\n"; }
    | error END { std::cout << "\n> Błąd składni.\n\n"; }
    | ERROR END { std::cout << "\n> Błąd składni.\n\n"; }
;

exp:
    SUB NUM %prec NEG   { $$.value = GF(-$2.value); $$.text = std::to_string($$.value) + ' '; }
    | NUM               { $$.value = GF( $1.value); $$.text = std::to_string($$.value) + ' '; }
    | exp ADD exp       { $$.value = GF($1.value) + GF($3.value); $$.text = $1.text + $3.text + "+ "; }
    | exp SUB exp       { $$.value = GF($1.value) - GF($3.value); $$.text = $1.text + $3.text + "- "; }
    | exp MUL exp       { $$.value = GF($1.value) * GF($3.value); $$.text = $1.text + $3.text + "* "; }
    | exp DIV exp       { try {$$.value = GF($1.value) / GF($3.value); $$.text = $1.text + $3.text + "/ ";} catch (gf::GFNoInverseException) {$$.text = std::to_string(GF($3.value)) + " nie jest odwracalne modulo " + std::to_string(GF::MAX_VALUE); }}
    | SUB exp %prec NEG { $$.value = GF(-$2.value); $$.text = $2.text; }
    | exp EXP expexp    { $$.value = GF($1.value) ^ GF($3.value); $$.text = $1.text + $3.text + "^ "; }
    | LPAR exp RPAR     { $$.value = GF($2.value); $$.text = $2.text; }
;

expexp:
    SUB NUM %prec NEG      { $$.value = GF2(-$2.value); $$.text = std::to_string($$.value) + ' '; }
    | NUM                  { $$.value = GF2( $1.value); $$.text = std::to_string($$.value) + ' '; }
    | expexp ADD expexp    { $$.value = GF2($1.value) + GF2($3.value); $$.text = $1.text + $3.text + "+ "; }
    | expexp SUB expexp    { $$.value = GF2($1.value) - GF2($3.value); $$.text = $1.text + $3.text + "- "; }
    | expexp MUL expexp    { $$.value = GF2($1.value) * GF2($3.value); $$.text = $1.text + $3.text + "* "; }
    | expexp DIV expexp    { try {$$.value = GF2($1.value) / GF2($3.value); $$.text = $1.text + $3.text + "/ ";} catch (gf::GFNoInverseException) {$$.text = std::to_string(GF2($3.value)) + " nie jest odwracalne modulo " + std::to_string(GF2::MAX_VALUE); }}
    | SUB expexp %prec NEG { $$.value = GF2(-$2.value); $$.text = $2.text; }
    | LPAR expexp RPAR     { $$.value = GF2($2.value); $$.text = $2.text; }
;

%%

int yyerror(char *const s)
{
   /* printf("%s\n",s); */
    return 0;
}
