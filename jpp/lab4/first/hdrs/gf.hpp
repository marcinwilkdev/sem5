#ifndef CPP_HPP
#define CPP_HPP

#include <exception>
#include <iostream>

namespace cpp {

long gcd(long a, long b, long &x, long &y);

class GFException : std::exception {};

class GFNegativeException : GFException {};

class GFTooBigException : GFException {};

class GFInverseOfZeroException : GFException {};

class GF {
private:
  static constexpr long MAX_VALUE = 1234567891;
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
  GF operator^(const GF &gf);
  // a^x = a^y mod p (p prime) x = y mod phi(p) (phi(p) == p-1)

  operator long();

  GF &operator=(const GF &gf);

  friend bool operator==(const GF &gf1, const GF &gf2);

  friend std::ostream &operator<<(std::ostream &out, const GF &gf);
  friend std::istream &operator>>(std::istream &in, GF &gf);
};

} // namespace cpp

#endif
