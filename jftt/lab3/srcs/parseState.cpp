#include "parseState.hpp"

#include <iostream>

#include "gf.hpp"

namespace parseState {

using GF = gf::GF<1234577>;
using GF2 = gf::GF<1234576>;

ParseState::ParseState() {}

ParseState::ParseState(std::string text) {
  this->value = std::stol(text);
  this->text = std::string{};
  this->isError = false;
}

ParseState ParseState::setNeg() {
  if (!this->isError) {
    this->value = GF(-this->value);
    this->text = std::to_string(this->value) + ' ';
  }

  return *this;
}

ParseState ParseState::setNum() {
  if (!this->isError) {
    this->value = GF(this->value);
    this->text = std::to_string(this->value) + ' ';
  }

  return *this;
}

ParseState ParseState::add(const ParseState& other) {
  if (!this->isError && other.isError) {
    this->text = other.text;
    this->isError = true;
  }

  if (!this->isError) {
    this->value = GF(this->value) + GF(other.value);
    this->text = this->text + other.text + "+ ";
  }

  return *this;
}

ParseState ParseState::sub(const ParseState& other) {
  if (!this->isError && other.isError) {
    this->text = other.text;
    this->isError = true;
  }

  if (!this->isError) {
    this->value = GF(this->value) - GF(other.value);
    this->text = this->text + other.text + "- ";
  }

  return *this;
}

ParseState ParseState::mul(const ParseState& other) {
  if (!this->isError && other.isError) {
    this->text = other.text;
    this->isError = true;
  }

  if (!this->isError) {
    this->value = GF(this->value) * GF(other.value);
    this->text = this->text + other.text + "* ";
  }

  return *this;
}

ParseState ParseState::div(const ParseState& other) {
  if (!this->isError && other.isError) {
    this->text = other.text;
    this->isError = true;
  }

  if (!this->isError) {
    try {
      this->value = GF(this->value) / GF(other.value);
      this->text = this->text + other.text + "/ ";
    } catch (gf::GFNoInverseException) {
      this->text = std::to_string(GF(other.value)) +
                   " nie jest odwracalne modulo " +
                   std::to_string(GF::MAX_VALUE);
      this->isError = true;
    }
  }

  return *this;
}

ParseState ParseState::neg() {
  if (!this->isError) {
    this->value = GF(-this->value);
  }

  return *this;
}

ParseState ParseState::exp(const ParseState& other) {
  if (!this->isError && other.isError) {
    this->text = other.text;
    this->isError = true;
  }

  if (!this->isError) {
    this->value = GF(this->value) ^ GF(other.value);
    this->text = this->text + other.text + "^ ";
  }

  return *this;
}

ParseState ParseState::setNegExp() {
  if (!this->isError) {
    this->value = GF2(-this->value);
    this->text = std::to_string(this->value) + ' ';
  }

  return *this;
}

ParseState ParseState::setNumExp() {
  if (!this->isError) {
    this->value = GF2(this->value);
    this->text = std::to_string(this->value) + ' ';
  }

  return *this;
}

ParseState ParseState::addExp(const ParseState& other) {
  if (!this->isError && other.isError) {
    this->text = other.text;
    this->isError = true;
  }

  if (!this->isError) {
    this->value = GF2(this->value) + GF2(other.value);
    this->text = this->text + other.text + "+ ";
  }

  return *this;
}

ParseState ParseState::subExp(const ParseState& other) {
  if (!this->isError && other.isError) {
    this->text = other.text;
    this->isError = true;
  }

  if (!this->isError) {
    this->value = GF2(this->value) - GF2(other.value);
    this->text = this->text + other.text + "- ";
  }

  return *this;
}

ParseState ParseState::divExp(const ParseState& other) {
  if (!this->isError && other.isError) {
    this->text = other.text;
    this->isError = true;
  }

  if (!this->isError) {
    try {
      this->value = GF2(this->value) / GF2(other.value);
      this->text = this->text + other.text + "/ ";
    } catch (gf::GFNoInverseException) {
      this->text = std::to_string(GF2(other.value)) +
                   " nie jest odwracalne modulo " +
                   std::to_string(GF2::MAX_VALUE);
      this->isError = true;
    }
  }

  return *this;
}

ParseState ParseState::mulExp(const ParseState& other) {
  if (!this->isError && other.isError) {
    this->text = other.text;
    this->isError = true;
  }

  if (!this->isError) {
    this->value = GF2(this->value) * GF2(other.value);
    this->text = this->text + other.text + "* ";
  }

  return *this;
}

ParseState ParseState::negExp() {
  if (!this->isError) {
    this->value = GF2(-this->value);
  }

  return *this;
}

std::ostream& operator<<(std::ostream& os, const ParseState& ps) {
  if (ps.isError) {
    os << "> " << ps.text << '\n';
  } else {
    os << ps.text << "\n= " << ps.value << '\n';
  }

  return os;
}

}  // namespace parseState
