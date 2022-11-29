#ifndef CPP_HPP
#define CPP_HPP

#include <exception>
#include <iostream>

namespace gf {

bool isPrime(long number);
long gcd(long a, long b, long &x, long &y);

class GFException : std::exception {};
class GFInverseOfZeroException : GFException {};
class GFNotPrimeException : GFException {};

template <long P>
class GF {
 private:
  static constexpr long MAX_VALUE = P;
  long number{};

 public:
  GF(long number);
  GF();

  GF inverse() const;

  GF operator+(const GF &gf) const;
  GF operator-(const GF &gf) const;
  GF operator*(const GF &gf) const;
  GF operator/(const GF &gf) const;
  GF operator^(const GF &gf) const;
  bool operator<(const GF &gf) const;
  bool operator>(const GF &gf) const;

  operator long();

  friend bool operator==(const GF<P> &gf1, const GF<P> &gf2) {
    return gf1.number == gf2.number;
  }

  friend std::ostream &operator<<(std::ostream &out, const GF<P> &gf) {
    out << "GF(" << gf.number << ")";

    return out;
  }

  friend std::istream &operator>>(std::istream &in, GF<P> &gf) {
    in >> gf.number;

    return in;
  }
};

template <long P>
GF<P> GF<P>::inverse() const {
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

template <long P>
GF<P>::GF(long number) {
  if (!gf::isPrime(P)) {
    throw GFNotPrimeException();
  }

  while (number < 0) {
    number += GF::MAX_VALUE;
  }

  this->number = number % GF::MAX_VALUE;
}

template <long P>
GF<P>::GF() {
  this->number = 0;
}

template <long P>
GF<P> GF<P>::operator+(const GF<P> &gf) const {
  const long newValue = (number + gf.number) % GF<P>::MAX_VALUE;

  return {newValue};
}

template <long P>
GF<P> GF<P>::operator-(const GF<P> &gf) const {
  long newValue = (number - gf.number) % GF<P>::MAX_VALUE;

  if (newValue < 0) {
    newValue += GF<P>::MAX_VALUE;
  }

  return {newValue};
}

template <long P>
GF<P> GF<P>::operator*(const GF<P> &gf) const {
  const long newValue = (number * gf.number) % GF<P>::MAX_VALUE;

  return {newValue};
}

template <long P>
GF<P> GF<P>::operator/(const GF<P> &gf) const {
  const long newValue = (number * gf.inverse().number) % GF<P>::MAX_VALUE;

  return {newValue};
}

template <long P>
GF<P> GF<P>::operator^(const GF<P> &gf) const {
  long number = this->number;
  long result = 1;

  long power = gf.number;

  while (power > 0) {
    if (power % 2 == 1) {
      result = (result * number) % GF<P>::MAX_VALUE;
    }

    number = (number * number) % GF<P>::MAX_VALUE;
    power /= 2;
  }

  return GF<P>(result);
}

template <long P>
bool GF<P>::operator<(const GF<P> &gf) const {
  return number < gf.number;
}

template <long P>
bool GF<P>::operator>(const GF<P> &gf) const {
  return number > gf.number;
}

template <long P>
GF<P>::operator long() {
  return number;
};

}  // namespace gf

#endif
