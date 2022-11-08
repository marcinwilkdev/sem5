#include "cpp.hpp"
#include <cassert>

namespace cpp {

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

GF GF::inverse() const {
  if (this->number == 0) {
    throw GFInverseOfZeroException();
  }

  long x{};
  long y{};

  gcd(this->number, GF::MAX_VALUE, x, y);

  if (x < 0) {
    x += GF::MAX_VALUE;
  }

  return x;
}

GF::GF(const long number) {
  if (number < 0) {
    throw GFNegativeException();
  }

  if (number >= MAX_VALUE) {
    throw GFTooBigException();
  }

  this->number = number;
}

GF GF::operator+(const GF &gf) {
  const long newValue = (number + gf.number) % GF::MAX_VALUE;

  return {newValue};
}

GF GF::operator-(const GF &gf) {
  long newValue = (number - gf.number) % GF::MAX_VALUE;

  if (newValue < 0) {
    newValue += GF::MAX_VALUE;
  }

  return {newValue};
}

GF GF::operator*(const GF &gf) {
  const long newValue = (number * gf.number) % GF::MAX_VALUE;

  return {newValue};
}

GF GF::operator/(const GF &gf) {
  const long newValue = (number * gf.inverse().number) % GF::MAX_VALUE;

  return {newValue};
}

bool GF::operator<(const GF &gf) { return number < gf.number; }

bool GF::operator>(const GF &gf) { return number > gf.number; }

GF GF::operator^(const GF &gf) {
  const GF reducedGf = {gf.number % (MAX_VALUE - 1)};
  
  //todo implement
}

GF::operator long() { return number; };

GF &GF::operator=(const GF &gf) {
  number = gf.number;

  return *this;
}

bool operator==(const GF &gf1, const GF &gf2) {
  return gf1.number == gf2.number;
}

std::ostream &operator<<(std::ostream &out, const GF &gf) {
  out << "GF(" << gf.number << ")";

  return out;
}

std::istream &operator>>(std::istream &in, GF &gf) {
  in >> gf.number;

  return in;
}

} // namespace cpp
