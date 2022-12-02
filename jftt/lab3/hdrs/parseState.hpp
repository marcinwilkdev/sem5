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
  ParseState(long value);
};

}  // namespace parseState

#endif
