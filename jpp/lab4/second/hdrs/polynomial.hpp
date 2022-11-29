#ifndef SECOND_HPP
#define SECOND_HPP

#include <array>
#include <iostream>
#include <vector>

namespace polynomial {

class PolynomialException : std::exception {};
class NoCoeffException : PolynomialException {};

template <typename T>
class Polynomial {
 private:
  std::vector<T> coefficients;

 public:
  Polynomial(const std::vector<T> &coefficients);

  template <std::size_t N>
  Polynomial(const std::array<T, N> &coefficients) {
    this->coefficients = coefficients;

    this->normalize();
  }

  Polynomial operator+(const Polynomial &polynomial) const;
  Polynomial operator-(const Polynomial &polynomial) const;
  Polynomial operator*(const Polynomial &polynomial) const;
  Polynomial operator/(const Polynomial &polynomial) const;
  Polynomial operator%(const Polynomial &polynomial) const;
  T &operator[](int coeffIdx);
  T operator()(const T &x) const;
  bool operator<(const Polynomial &polynomial) const;
  bool operator>(const Polynomial &polynomial) const;

  friend bool operator==(const Polynomial<T> &pol1, const Polynomial<T> &pol2) {
    if (pol1.coefficients.size() != pol2.coefficients.size()) {
      return false;
    }

    for (int coeffIdx{0}; coeffIdx < pol1.coefficients.size(); ++coeffIdx) {
      if (pol1.coefficients[coeffIdx] < pol2.coefficients[coeffIdx] ||
          pol1.coefficients[coeffIdx] > pol2.coefficients[coeffIdx]) {
        return false;
      }
    }

    return true;
  }

  friend std::ostream &operator<<(std::ostream &out,
                                  Polynomial<T> &polynomial) {
    for (int coeffIdx{static_cast<int>(polynomial.coefficients.size() - 1)};
         coeffIdx >= 0; --coeffIdx) {
      if (coeffIdx == 0) {
        out << polynomial.coefficients[coeffIdx];
      } else {
        out << polynomial.coefficients[coeffIdx] << "x^" << coeffIdx << " + ";
      }
    }

    return out;
  }

  friend std::istream &operator>>(std::istream &in, Polynomial<T> &polynomial) {
    std::vector<T> coefficients;

    for (int coeffIdx{polynomial.coefficients.size() - 1}; coeffIdx >= 0;
         --coeffIdx) {
      in >> polynomial.coefficients[coeffIdx];
    }

    return in;
  }

 private:
  void normalize();
};

template <typename T>
Polynomial<T>::Polynomial(const std::vector<T> &coefficients) {
  this->coefficients = coefficients;

  this->normalize();
}

template <typename T>
Polynomial<T> Polynomial<T>::operator+(const Polynomial<T> &polynomial) const {
  auto maxDegree{this->coefficients.size() > polynomial.coefficients.size()
                     ? this->coefficients.size()
                     : polynomial.coefficients.size()};

  std::vector<T> newCoefficients(maxDegree);

  for (std::size_t coeffIdx{0}; coeffIdx < maxDegree; ++coeffIdx) {
    if (coeffIdx < this->coefficients.size() &&
        coeffIdx < polynomial.coefficients.size()) {
      newCoefficients[coeffIdx] =
          this->coefficients[coeffIdx] + polynomial.coefficients[coeffIdx];
    } else if (coeffIdx < this->coefficients.size()) {
      newCoefficients[coeffIdx] = this->coefficients[coeffIdx];
    } else {
      newCoefficients[coeffIdx] = polynomial.coefficients[coeffIdx];
    }
  }

  Polynomial<T> result{newCoefficients};

  result.normalize();

  return result;
}

template <typename T>
Polynomial<T> Polynomial<T>::operator-(const Polynomial<T> &polynomial) const {
  auto maxDegree{this->coefficients.size() > polynomial.coefficients.size()
                     ? this->coefficients.size()
                     : polynomial.coefficients.size()};

  std::vector<T> newCoefficients(maxDegree);

  for (std::size_t coeffIdx{0}; coeffIdx < this->coefficients.size();
       ++coeffIdx) {
    newCoefficients[coeffIdx] = this->coefficients[coeffIdx];
  }

  for (std::size_t coeffIdx{0}; coeffIdx < polynomial.coefficients.size();
       ++coeffIdx) {
    newCoefficients[coeffIdx] =
        newCoefficients[coeffIdx] - polynomial.coefficients[coeffIdx];
  }

  Polynomial<T> result{newCoefficients};

  result.normalize();

  return result;
}

template <typename T>
Polynomial<T> Polynomial<T>::operator*(const Polynomial<T> &polynomial) const {
  auto resultDegree{this->coefficients.size() + polynomial.coefficients.size() -
                    1};

  if (resultDegree < 0) {
    resultDegree = 0;
  }

  std::vector<T> newCoefficients(resultDegree);

  for (int coeffIdx{0}; coeffIdx < static_cast<int>(this->coefficients.size());
       ++coeffIdx) {
    for (int otherCoeffIdx{0};
         otherCoeffIdx < static_cast<int>(polynomial.coefficients.size());
         ++otherCoeffIdx) {
      newCoefficients[coeffIdx + otherCoeffIdx] =
          newCoefficients[coeffIdx + otherCoeffIdx] +
          this->coefficients[coeffIdx] * polynomial.coefficients[otherCoeffIdx];
    }
  }

  Polynomial<T> result{newCoefficients};

  result.normalize();

  return result;
}

template <typename T>
Polynomial<T> Polynomial<T>::operator/(const Polynomial<T> &polynomial) const {
  Polynomial<T> remainder{this->coefficients};
  Polynomial<T> quotient{std::vector<T>(
      this->coefficients.size() > polynomial.coefficients.size()
          ? this->coefficients.size() - polynomial.coefficients.size()
          : 0)};

  while (remainder.coefficients.size() >= polynomial.coefficients.size()) {
    T coeff{remainder.coefficients.back() / polynomial.coefficients.back()};

    std::vector<T> newCoefficients(remainder.coefficients.size() -
                                   polynomial.coefficients.size() + 1);

    newCoefficients.back() = coeff;

    Polynomial<T> newPolynomial{newCoefficients};

    quotient = quotient + newPolynomial;

    remainder = remainder - (polynomial * newPolynomial);

    remainder.normalize();
  }

  quotient.normalize();

  return quotient;
}

template <typename T>
Polynomial<T> Polynomial<T>::operator%(const Polynomial<T> &polynomial) const {
  Polynomial<T> remainder{this->coefficients};
  Polynomial<T> quotient{std::vector<T>(
      this->coefficients.size() > polynomial.coefficients.size()
          ? this->coefficients.size() - polynomial.coefficients.size()
          : 0)};

  while (remainder.coefficients.size() >= polynomial.coefficients.size()) {
    T coeff{remainder.coefficients.back() / polynomial.coefficients.back()};

    std::vector<T> newCoefficients(remainder.coefficients.size() -
                                   polynomial.coefficients.size() + 1);

    newCoefficients.back() = coeff;

    Polynomial<T> newPolynomial{newCoefficients};

    quotient = quotient + newPolynomial;

    remainder = remainder - (polynomial * newPolynomial);

    remainder.normalize();
  }

  remainder.normalize();

  return remainder;
}

template <typename T>
bool Polynomial<T>::operator<(const Polynomial<T> &polynomial) const {
  if (this->coefficients.size() < polynomial.coefficients.size()) {
    return true;
  } else if (this->coefficients.size() > polynomial.coefficients.size()) {
    return false;
  } else {
    for (int coeffIdx{0}; coeffIdx < this->coefficients.size(); ++coeffIdx) {
      if (this->coefficients[coeffIdx] < polynomial.coefficients[coeffIdx]) {
        return true;
      } else if (this->coefficients[coeffIdx] >
                 polynomial.coefficients[coeffIdx]) {
        return false;
      }
    }
  }

  return false;
}

template <typename T>
bool Polynomial<T>::operator>(const Polynomial<T> &polynomial) const {
  if (this->coefficients.size() > polynomial.coefficients.size()) {
    return true;
  } else if (this->coefficients.size() < polynomial.coefficients.size()) {
    return false;
  } else {
    for (int coeffIdx{0}; coeffIdx < this->coefficients.size(); ++coeffIdx) {
      if (this->coefficients[coeffIdx] > polynomial.coefficients[coeffIdx]) {
        return true;
      } else if (this->coefficients[coeffIdx] <
                 polynomial.coefficients[coeffIdx]) {
        return false;
      }
    }
  }

  return false;
}

template <typename T>
T &Polynomial<T>::operator[](const int coeffIdx) {
  if (coeffIdx < 0 || coeffIdx >= static_cast<int>(this->coefficients.size())) {
    throw NoCoeffException();
  }

  return this->coefficients[coeffIdx];
}

template <typename T>
T Polynomial<T>::operator()(const T &value) const {
  T result = T();

  for (std::size_t coeffIdx{0}; coeffIdx < this->coefficients.size();
       ++coeffIdx) {
    result = result + this->coefficients[coeffIdx] * (value ^ coeffIdx);
  }

  return result;
}

template <typename T>
void Polynomial<T>::normalize() {
  for (int coeffIdx{static_cast<int>(this->coefficients.size() - 1)};
       coeffIdx >= 0; --coeffIdx) {
    T neutralElement = T();

    if (this->coefficients[coeffIdx] > neutralElement) {
      break;
    }

    this->coefficients.pop_back();
  }
}

}  // namespace polynomial

#endif
