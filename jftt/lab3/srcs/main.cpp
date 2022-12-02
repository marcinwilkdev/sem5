#include <cstdlib>

#include "parser.hpp"
#include "gf.hpp"

int main(void) {
  yyparse();

  return EXIT_SUCCESS;
}
