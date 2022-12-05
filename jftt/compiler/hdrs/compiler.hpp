#ifndef COMPILER_HPP
#define COMPILER_HPP

#include <string>

namespace compiler {

enum class VariableState {
  NoId,
  NoValue,
  Correct,
};

class Variable {
 private:
  std::string id{};
  long long value{};
  VariableState state{};

 public:
  Variable();
  Variable(std::string_view id);
  Variable(long long value);

  static Variable fromId(std::string_view id);
  static Variable fromValue(const std::string& value);

  friend std::ostream& operator<<(std::ostream& os, const Variable& var);
};

}  // namespace compiler

#endif
