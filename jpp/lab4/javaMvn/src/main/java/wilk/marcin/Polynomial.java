package wilk.marcin;

import java.util.*;

public class Polynomial<P extends PolynomialType<P>> {
  private ArrayList<P> coefficients;

  public Polynomial(final ArrayList<P> coefficients) {
    this.coefficients = coefficients;
    this.normalize();
  }

  public Polynomial(final P[] coefficients) {
    this.coefficients = new ArrayList<>(Arrays.asList(coefficients));
    this.normalize();
  }

  public Polynomial<P> add(Polynomial<P> other) {
    final int maxDegree =
        this.coefficients.size() > other.coefficients.size()
            ? this.coefficients.size()
            : other.coefficients.size();

    if (maxDegree == 0) {
      return new Polynomial<P>(new ArrayList<>());
    }

    P neutralElement =
        this.coefficients.size() > 0
            ? this.coefficients.get(0).neutral()
            : other.coefficients.get(0).neutral();

    ArrayList<P> newCoefficients = new ArrayList<>();

    for (int i = 0; i < maxDegree; i++) {
      newCoefficients.add(neutralElement);
    }

    for (int coeffIdx = 0; coeffIdx < maxDegree; coeffIdx++) {
      if (coeffIdx < this.coefficients.size() && coeffIdx < other.coefficients.size()) {
        P firstElement = this.coefficients.get(coeffIdx);
        P secondElement = other.coefficients.get(coeffIdx);

        newCoefficients.set(coeffIdx, firstElement.add(secondElement));
      } else if (coeffIdx < this.coefficients.size()) {
        newCoefficients.set(coeffIdx, this.coefficients.get(coeffIdx));
      } else {
        newCoefficients.set(coeffIdx, other.coefficients.get(coeffIdx));
      }
    }

    Polynomial<P> result = new Polynomial<>(newCoefficients);

    result.normalize();

    return result;
  }

  @Override
  public boolean equals(Object obj) {
    if (obj == null || !(obj instanceof Polynomial)) {
      return false;
    }

    return this.coefficients.equals(((Polynomial<P>) obj).coefficients);
  }

  @Override
  public String toString() {
    if (this.coefficients.size() == 0) {
      return "0";
    }

    StringBuilder sb = new StringBuilder();

    for (int coeffIdx = this.coefficients.size() - 1; coeffIdx >= 0; coeffIdx--) {
      P coeff = this.coefficients.get(coeffIdx);

      if (!coeff.equals(coeff.neutral())) {
        if (coeffIdx < this.coefficients.size() - 1) {
          sb.append(" + ");
        }

        sb.append(coeff.toString());

        if (coeffIdx > 0) {
          sb.append("x^");
          sb.append(coeffIdx);
        }
      }
    }

    return sb.toString();
  }

  private void normalize() {
    if (this.coefficients.size() == 0) {
      return;
    }

    for (int coeffIdx = this.coefficients.size() - 1; coeffIdx >= 0; --coeffIdx) {
      final P neutralElement = this.coefficients.get(0).neutral();

      if (!this.coefficients.get(coeffIdx).equals(neutralElement)) {
        break;
      }

      this.coefficients.remove(coeffIdx);
    }
  }
}

//   friend bool operator==(const Polynomial<T> &pol1, const Polynomial<T> &pol2) {
//     if (pol1.coefficients.size() != pol2.coefficients.size()) {
//       return false;
//     }

//     for (int coeffIdx{0}; coeffIdx < pol1.coefficients.size(); ++coeffIdx) {
//       if (pol1.coefficients[coeffIdx] == pol2.coefficients[coeffIdx]) {
//         return false;
//       }
//     }

//     return true;
//   }

//   friend std::ostream &operator<<(std::ostream &out,
//                                   Polynomial<T> &polynomial) {
//     if (polynomial.coefficients.size() == 0) {
//       out << "0";
//     } else {
//       T neutralElement = T();

//       for (int coeffIdx{static_cast<int>(polynomial.coefficients.size() - 1)};
//            coeffIdx >= 0; --coeffIdx) {
//         if (!(polynomial.coefficients[coeffIdx] == neutralElement)) {
//           if (coeffIdx < static_cast<int>(polynomial.coefficients.size() - 1)) {
//             out << " + ";
//           }

//           out << polynomial.coefficients[coeffIdx];

//           if (coeffIdx > 0) {
//             out << "x^" << coeffIdx;
//           }
//         }
//       }
//     }

//     return out;
//   }

//  private:

// template <typename T>
// Polynomial<T> Polynomial<T>::operator+(const Polynomial<T> &polynomial) const {
//   auto maxDegree{this->coefficients.size() > polynomial.coefficients.size()
//                      ? this->coefficients.size()
//                      : polynomial.coefficients.size()};

//   std::vector<T> newCoefficients(maxDegree);

//   for (std::size_t coeffIdx{0}; coeffIdx < maxDegree; ++coeffIdx) {
//     if (coeffIdx < this->coefficients.size() &&
//         coeffIdx < polynomial.coefficients.size()) {
//       newCoefficients[coeffIdx] =
//           this->coefficients[coeffIdx] + polynomial.coefficients[coeffIdx];
//     } else if (coeffIdx < this->coefficients.size()) {
//       newCoefficients[coeffIdx] = this->coefficients[coeffIdx];
//     } else {
//       newCoefficients[coeffIdx] = polynomial.coefficients[coeffIdx];
//     }
//   }

//   Polynomial<T> result{newCoefficients};

//   result.normalize();

//   return result;
// }

// template <typename T>
// Polynomial<T> Polynomial<T>::operator-(const Polynomial<T> &polynomial) const {
//   auto maxDegree{this->coefficients.size() > polynomial.coefficients.size()
//                      ? this->coefficients.size()
//                      : polynomial.coefficients.size()};

//   std::vector<T> newCoefficients(maxDegree);

//   for (std::size_t coeffIdx{0}; coeffIdx < this->coefficients.size();
//        ++coeffIdx) {
//     newCoefficients[coeffIdx] = this->coefficients[coeffIdx];
//   }

//   for (std::size_t coeffIdx{0}; coeffIdx < polynomial.coefficients.size();
//        ++coeffIdx) {
//     newCoefficients[coeffIdx] =
//         newCoefficients[coeffIdx] - polynomial.coefficients[coeffIdx];
//   }

//   Polynomial<T> result{newCoefficients};

//   result.normalize();

//   return result;
// }

// template <typename T>
// Polynomial<T> Polynomial<T>::operator*(const Polynomial<T> &polynomial) const {
//   auto resultDegree{this->coefficients.size() + polynomial.coefficients.size() -
//                     1};

//   if (resultDegree < 0) {
//     resultDegree = 0;
//   }

//   std::vector<T> newCoefficients(resultDegree);

//   for (int coeffIdx{0}; coeffIdx < static_cast<int>(this->coefficients.size());
//        ++coeffIdx) {
//     for (int otherCoeffIdx{0};
//          otherCoeffIdx < static_cast<int>(polynomial.coefficients.size());
//          ++otherCoeffIdx) {
//       newCoefficients[coeffIdx + otherCoeffIdx] =
//           newCoefficients[coeffIdx + otherCoeffIdx] +
//           this->coefficients[coeffIdx] * polynomial.coefficients[otherCoeffIdx];
//     }
//   }

//   Polynomial<T> result{newCoefficients};

//   result.normalize();

//   return result;
// }

// template <typename T>
// Polynomial<T> Polynomial<T>::operator/(const Polynomial<T> &polynomial) const {
//   Polynomial<T> remainder{this->coefficients};
//   Polynomial<T> quotient{std::vector<T>(
//       this->coefficients.size() > polynomial.coefficients.size()
//           ? this->coefficients.size() - polynomial.coefficients.size()
//           : 0)};

//   while (remainder.coefficients.size() >= polynomial.coefficients.size()) {
//     T coeff{remainder.coefficients.back() / polynomial.coefficients.back()};

//     std::vector<T> newCoefficients(remainder.coefficients.size() -
//                                    polynomial.coefficients.size() + 1);

//     newCoefficients.back() = coeff;

//     Polynomial<T> newPolynomial{newCoefficients};

//     quotient = quotient + newPolynomial;

//     remainder = remainder - (polynomial * newPolynomial);

//     remainder.normalize();
//   }

//   quotient.normalize();

//   return quotient;
// }

// template <typename T>
// Polynomial<T> Polynomial<T>::operator%(const Polynomial<T> &polynomial) const {
//   Polynomial<T> remainder{this->coefficients};
//   Polynomial<T> quotient{std::vector<T>(
//       this->coefficients.size() > polynomial.coefficients.size()
//           ? this->coefficients.size() - polynomial.coefficients.size()
//           : 0)};

//   while (remainder.coefficients.size() >= polynomial.coefficients.size()) {
//     T coeff{remainder.coefficients.back() / polynomial.coefficients.back()};

//     std::vector<T> newCoefficients(remainder.coefficients.size() -
//                                    polynomial.coefficients.size() + 1);

//     newCoefficients.back() = coeff;

//     Polynomial<T> newPolynomial{newCoefficients};

//     quotient = quotient + newPolynomial;

//     remainder = remainder - (polynomial * newPolynomial);

//     remainder.normalize();
//   }

//   remainder.normalize();

//   return remainder;
// }

// template <typename T>
// bool Polynomial<T>::operator<(const Polynomial<T> &polynomial) const {
//   if (this->coefficients.size() < polynomial.coefficients.size()) {
//     return true;
//   } else if (this->coefficients.size() > polynomial.coefficients.size()) {
//     return false;
//   } else {
//     for (int coeffIdx{0}; coeffIdx < this->coefficients.size(); ++coeffIdx) {
//       if (this->coefficients[coeffIdx] < polynomial.coefficients[coeffIdx]) {
//         return true;
//       } else if (this->coefficients[coeffIdx] >
//                  polynomial.coefficients[coeffIdx]) {
//         return false;
//       }
//     }
//   }

//   return false;
// }

// template <typename T>
// bool Polynomial<T>::operator>(const Polynomial<T> &polynomial) const {
//   if (this->coefficients.size() > polynomial.coefficients.size()) {
//     return true;
//   } else if (this->coefficients.size() < polynomial.coefficients.size()) {
//     return false;
//   } else {
//     for (int coeffIdx{0}; coeffIdx < this->coefficients.size(); ++coeffIdx) {
//       if (this->coefficients[coeffIdx] > polynomial.coefficients[coeffIdx]) {
//         return true;
//       } else if (this->coefficients[coeffIdx] <
//                  polynomial.coefficients[coeffIdx]) {
//         return false;
//       }
//     }
//   }

//   return false;
// }

// template <typename T>
// T &Polynomial<T>::operator[](const int coeffIdx) {
//   if (coeffIdx < 0 || coeffIdx >= static_cast<int>(this->coefficients.size())) {
//     throw NoCoeffException();
//   }

//   return this->coefficients[coeffIdx];
// }

// template <typename T>
// T Polynomial<T>::operator()(const T &value) const {
//   T result = T();

//   for (std::size_t coeffIdx{0}; coeffIdx < this->coefficients.size();
//        ++coeffIdx) {
//     result = result + this->coefficients[coeffIdx] * (value ^ coeffIdx);
//   }

//   return result;
// }

// template <typename T>
// void Polynomial<T>::normalize() {
//   for (int coeffIdx{static_cast<int>(this->coefficients.size() - 1)};
//        coeffIdx >= 0; --coeffIdx) {
//     T neutralElement = T();

//     if (this->coefficients[coeffIdx] > neutralElement) {
//       break;
//     }

//     this->coefficients.pop_back();
//   }
// }
