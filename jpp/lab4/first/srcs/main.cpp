#include "cpp.hpp"
#include <cstdlib>
#include <iostream>

int main(void) {
  cpp::GF<1234567891> gf{0};

  std::cout << cpp::GF<1234567891>(100) << '\n';
  std::cin >> gf;
  
  std::cout << gf.inverse();

  return EXIT_SUCCESS;
}
