#include "cpp.hpp"

namespace cpp {

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
  if (gf.number == 0) {
    throw GFDivisionByZeroException();
  }

  const long newValue = (number / gf.number);

  return {newValue};
}

bool GF::operator<(const GF &gf) { return number < gf.number; }

bool GF::operator>(const GF &gf) { return number > gf.number; }

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
