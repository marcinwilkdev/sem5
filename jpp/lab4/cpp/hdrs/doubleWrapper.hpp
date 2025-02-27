#ifndef DOUBLE_WRAPPER_HPP
#define DOUBLE_WRAPPER_HPP

#include <iostream>

namespace doubleWrapper {

class DoubleWrapper {
 private:
  double value{};

 public:
  DoubleWrapper(double value);
  DoubleWrapper();

  DoubleWrapper operator+(const DoubleWrapper dw) const;
  DoubleWrapper operator-(const DoubleWrapper dw) const;
  DoubleWrapper operator*(const DoubleWrapper dw) const;
  DoubleWrapper operator/(const DoubleWrapper dw) const;
  DoubleWrapper operator^(const DoubleWrapper dw) const;
  bool operator<(const DoubleWrapper dw) const;
  bool operator>(const DoubleWrapper dw) const;

  friend bool operator==(const DoubleWrapper &dw1, const DoubleWrapper &dw2) {
    return dw1.value == dw2.value;
  }

  friend std::ostream &operator<<(std::ostream &out, DoubleWrapper &dw) {
    out << dw.value;

    return out;
  }
};

}  // namespace doubleWrapper

#endif
