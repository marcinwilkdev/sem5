#include "cpp.hpp"
#include <cstdlib>
#include <iostream>

int main(void) {
  cpp::GF gf{0};

  std::cout << cpp::GF(100) << '\n';
  std::cin >> gf;
  
  std::cout << gf.inverse();

  return EXIT_SUCCESS;
}
