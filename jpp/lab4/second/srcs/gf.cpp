#include "gf.hpp"

#include <cassert>

namespace gf {

bool isPrime(const long number) {
  for (long i = 2; i * i <= number; ++i) {
    if (number % i == 0) {
      return false;
    }
  }

  return true;
}

long gcd(const long a, const long b, long &x, long &y) {
  x = 1, y = 0;
  long x1 = 0, y1 = 1, a1 = a, b1 = b;

  while (b1) {
    long q = a1 / b1;

    const long x1Tmp = x1;
    x1 = x - q * x1;
    x = x1Tmp;

    const long y1Tmp = y1;
    y1 = y - q * y1;
    y = y1Tmp;

    const long b1Tmp = b1;
    b1 = a1 - q * b1;
    a1 = b1Tmp;
  }

  return a1;
}

}  // namespace gf
