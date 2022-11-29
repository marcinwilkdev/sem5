#include "doubleWrapper.hpp"

#include <cmath>

namespace doubleWrapper {

DoubleWrapper::DoubleWrapper(const double value) { this->value = value; }
DoubleWrapper::DoubleWrapper() { this->value = 0; }

DoubleWrapper DoubleWrapper::operator+(const DoubleWrapper dw) const {
  return DoubleWrapper(this->value + dw.value);
}

DoubleWrapper DoubleWrapper::operator-(const DoubleWrapper dw) const {
  return DoubleWrapper(this->value - dw.value);
}

DoubleWrapper DoubleWrapper::operator*(const DoubleWrapper dw) const {
  return DoubleWrapper(this->value * dw.value);
}

DoubleWrapper DoubleWrapper::operator/(const DoubleWrapper dw) const {
  return DoubleWrapper(this->value / dw.value);
}

DoubleWrapper DoubleWrapper::operator^(const DoubleWrapper dw) const {
  return DoubleWrapper(std::pow(this->value, dw.value));
}

bool DoubleWrapper::operator<(const DoubleWrapper dw) const {
  return this->value < dw.value;
}

bool DoubleWrapper::operator>(const DoubleWrapper dw) const {
  return this->value > dw.value;
}

}  // namespace doubleWrapper
