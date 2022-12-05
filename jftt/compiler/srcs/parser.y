%code requires {
  #include <iostream>
  #include "../hdrs/compiler.hpp"
  // includes for lexer and parser
}

%{
  #include <sstream>

  int yylex(void);
  int yyerror(char*);
%}

%define api.value.type {compiler::Variable}

%token PROCEDURE
%token IS
%token VAR
%token BEG
%token END
%token PROGRAM
%token IF
%token THEN
%token ELSE
%token ENDIF
%token WHILE
%token DO
%token ENDWHILE
%token REPEAT
%token UNTIL
%token READ
%token WRITE
%token LPAR
%token RPAR
%token SEMICOLON
%token ASSIGN
%token COMMA

%left ADD SUB
%left MUL DIV
%left MOD

%token EQ
%token NEQ
%token GT
%token LT
%token GE
%token LE

%token NUM
%token ID

%token ERROR

// differentiate declarations

%%

program_all:
      procedures main 
;

procedures:
      procedures PROCEDURE proc_head IS VAR declarations BEG commands END
    | procedures PROCEDURE proc_head IS BEG commands END
    | %empty
;

main:
      PROGRAM IS VAR declarations BEG commands END
    | PROGRAM IS BEG commands END
;

commands:
      commands command
    | command
;

command:
      ID ASSIGN expression SEMICOLON
    | IF condition THEN commands ELSE commands ENDIF
    | IF condition THEN commands ENDIF
    | WHILE condition DO commands ENDWHILE
    | REPEAT commands UNTIL condition SEMICOLON
    | proc_head SEMICOLON
    | READ ID SEMICOLON
    | WRITE value SEMICOLON
;

proc_head: ID LPAR declarations RPAR
;

declarations:
      declarations COMMA ID
    | ID
;

expression:
      value
    | value ADD value
    | value SUB value
    | value MUL value
    | value DIV value
    | value MOD value
;

condition:
      value EQ value
    | value NEQ value
    | value GT value
    | value LT value
    | value GE value
    | value LE value
;

value:
      NUM { $$ = $1; std::cout << $1 << '\n'; }
    | ID  { $$ = $1; std::cout << $1 << '\n'; } 
;

%%

int yyerror(char *const s)
{
    std::cout << "ERROR: " << s << '\n';
    return 0;
}
