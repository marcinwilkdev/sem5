#include <cstdlib>
#include <iostream>

#include "second.hpp"

int main(void) {
  auto pol1 = second::Polynomial<long>({-1, 2, 0, 1});
  auto pol2 = second::Polynomial<long>({-1, 1});

  std::cout << pol1 << std::endl;
  std::cout << pol2 << std::endl;

  std::cout << pol1 / pol2 << std::endl;
  std::cout << pol1 % pol2 << std::endl;

  return EXIT_SUCCESS;
}
