#include "compiler.hpp"

#include <sstream>

namespace compiler {

Variable::Variable() {}

Variable::Variable(const std::string_view id) {
  this->id = id;
  this->state = VariableState::NoValue;
}

Variable::Variable(const long long value) {
  this->value = value;
  this->state = VariableState::NoId;
}

Variable Variable::fromId(const std::string_view id) { return Variable(id); }
Variable Variable::fromValue(const std::string& value) {
  std::stringstream ss{value};

  long long longValue{};
  ss >> longValue;

  return Variable(longValue);
}

std::ostream& operator<<(std::ostream& os, const Variable& var) {
  if (var.state == VariableState::NoId) {
    os << var.value;
  } else if (var.state == VariableState::NoValue) {
    os << var.id;
  } else {
    os << var.id << " = " << var.value;
  }

  return os;
}

}  // namespace compiler
