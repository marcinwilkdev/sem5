#ifndef CPP_HPP
#define CPP_HPP

#include <exception>
#include <iostream>

namespace cpp {

bool isPrime(long number);

long gcd(long a, long b, long &x, long &y);

class GFException : std::exception {};

class GFNegativeException : GFException {};

class GFTooBigException : GFException {};

class GFInverseOfZeroException : GFException {};

class GFNotPrimeException : GFException {};

template <long P>
class GF {
 private:
  static constexpr long MAX_VALUE = P;
  long number{};

 public:
  GF(const long number);

  GF inverse() const;

  GF operator+(const GF &gf);
  GF operator-(const GF &gf);
  GF operator*(const GF &gf);
  GF operator/(const GF &gf);
  bool operator<(const GF &gf);
  bool operator>(const GF &gf);

  operator long();

  GF &operator=(const GF &gf);

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
GF<P>::GF(const long number) {
  if (!cpp::isPrime(P)) {
    throw GFNotPrimeException();
  }

  if (number < 0) {
    throw GFNegativeException();
  }

  if (number >= MAX_VALUE) {
    throw GFTooBigException();
  }

  this->number = number;
}

template <long P>
GF<P> GF<P>::operator+(const GF<P> &gf) {
  const long newValue = (number + gf.number) % GF<P>::MAX_VALUE;

  return {newValue};
}

template <long P>
GF<P> GF<P>::operator-(const GF<P> &gf) {
  long newValue = (number - gf.number) % GF<P>::MAX_VALUE;

  if (newValue < 0) {
    newValue += GF<P>::MAX_VALUE;
  }

  return {newValue};
}

template <long P>
GF<P> GF<P>::operator*(const GF<P> &gf) {
  const long newValue = (number * gf.number) % GF<P>::MAX_VALUE;

  return {newValue};
}

template <long P>
GF<P> GF<P>::operator/(const GF<P> &gf) {
  const long newValue = (number * gf.inverse().number) % GF<P>::MAX_VALUE;

  return {newValue};
}

template <long P>
bool GF<P>::operator<(const GF<P> &gf) {
  return number < gf.number;
}

template <long P>
bool GF<P>::operator>(const GF<P> &gf) {
  return number > gf.number;
}

template <long P>
GF<P>::operator long() {
  return number;
};

template <long P>
GF<P> &GF<P>::operator=(const GF<P> &gf) {
  number = gf.number;

  return *this;
}

}  // namespace cpp

#endif
