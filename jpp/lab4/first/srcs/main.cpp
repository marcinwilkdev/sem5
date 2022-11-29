#include <cstdlib>
#include <iostream>

#include "cpp.hpp"

int main(void) {
  cpp::GF<1234567891> gf{0};

  std::cout << cpp::GF<1234567891>(100) << '\n';
  std::cin >> gf;

  cpp::GF<1234567891> gf1{gf ^ cpp::GF<1234567891>(999999999)};

  std::cout << gf.inverse() << '\n';
  std::cout << gf1 << '\n';

  return EXIT_SUCCESS;
}
