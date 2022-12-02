#ifndef PARSE_STATE_HPP
#define PARSE_STATE_HPP

#include <string>

namespace parseState {

class ParseState {
 private:
  long value{0};
  std::string text{};
  bool isError{false};

 public:
  ParseState();
  ParseState(std::string text);

  ParseState setNeg();
  ParseState setNum();
  ParseState add(const ParseState& other);
  ParseState sub(const ParseState& other);
  ParseState mul(const ParseState& other);
  ParseState div(const ParseState& other);
  ParseState neg();
  ParseState exp(const ParseState& other);

  ParseState setNegExp();
  ParseState setNumExp();
  ParseState addExp(const ParseState& other);
  ParseState subExp(const ParseState& other);
  ParseState mulExp(const ParseState& other);
  ParseState divExp(const ParseState& other);
  ParseState negExp();

  friend std::ostream& operator<<(std::ostream& os, const ParseState& ps);
};

}  // namespace parseState

#endif
