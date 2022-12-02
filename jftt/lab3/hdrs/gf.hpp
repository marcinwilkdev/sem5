#ifndef GF_HPP
#define GF_HPP

#include <iostream>

namespace gf {

class GFException : std::exception {};
class GFNoInverseException : GFException {};

template <long P>
class GF {
 public:
  static constexpr long MAX_VALUE = P;

 private:
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
  bool operator==(const GF &gf) const;

  operator long();

  friend std::ostream &operator<<(std::ostream &out, const GF<P> &gf) {
    out << gf.number;

    return out;
  }

  friend std::istream &operator>>(std::istream &in, GF<P> &gf) {
    in >> gf.number;

    return in;
  }
};

template <long P>
GF<P>::GF(long number) {
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
GF<P> GF<P>::inverse() const {
  if (this->number == 0) {
    throw GFNoInverseException();
  }

  long x = 1;
  long y = 0;

  long x1 = 0;
  long y1 = 1;
  long b1 = GF::MAX_VALUE;
  long a1 = this->number;

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

  if (a1 > 1) {
    throw GFNoInverseException();
  }

  return GF<P>(x);
}

template <long P>
GF<P> GF<P>::operator+(const GF<P> &gf) const {
  return GF<P>(this->number + gf.number);
}

template <long P>
GF<P> GF<P>::operator-(const GF<P> &gf) const {
  return GF<P>(this->number - gf.number);
}

template <long P>
GF<P> GF<P>::operator*(const GF<P> &gf) const {
  return GF<P>(this->number * gf.number);
}

template <long P>
GF<P> GF<P>::operator/(const GF<P> &gf) const {
  return (*this) * gf.inverse();
}

template <long P>
GF<P> GF<P>::operator^(const GF<P> &gf) const {
  long number = this->number;
  long result = 1;

  std::string a{std::to_string(result)};

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
  return this->number < gf.number;
}

template <long P>
bool GF<P>::operator>(const GF<P> &gf) const {
  return this->number > gf.number;
}

template <long P>
bool GF<P>::operator==(const GF<P> &gf) const {
  return this->number == gf.number;
}

template <long P>
GF<P>::operator long() {
  return this->number;
};

}  // namespace gf

#endif
