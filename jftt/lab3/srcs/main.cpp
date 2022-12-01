#include <cstdlib>

#include "parser.hpp"
#include "project.hpp"

int main(void) {
  yyparse();

  return EXIT_SUCCESS;
}
