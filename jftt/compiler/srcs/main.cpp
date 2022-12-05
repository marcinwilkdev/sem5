#include <cstdlib>

#include "compiler.hpp"
#include "parser.hpp"

int main(void) {
  yyparse();

  return EXIT_SUCCESS;
}
