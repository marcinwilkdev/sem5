#ifndef HAMMING_HPP
#define HAMMING_HPP

#include "gf.hpp"
#include "polynomial.hpp"

namespace hamming {

using GF2Polynomial = polynomial::Polynomial<gf::GF<2>>;

GF2Polynomial encode(const GF2Polynomial& code);
GF2Polynomial decode(GF2Polynomial& code);

class CodeTooLongException : std::exception {};
class TwoErrorsException : std::exception {};

}  // namespace hamming

#endif
