#include "hamming.hpp"

namespace hamming {

static const GF2Polynomial generatorPolynomial{
    std::vector<gf::GF<2>>{1, 0, 1, 1}};

static const std::array<GF2Polynomial, 8> remainderTable{{
    std::vector<gf::GF<2>>{1},
    std::vector<gf::GF<2>>{0, 1},
    std::vector<gf::GF<2>>{0, 0, 1},
    std::vector<gf::GF<2>>{1, 0, 1},
    std::vector<gf::GF<2>>{1, 1, 1},
    std::vector<gf::GF<2>>{1, 1},
    std::vector<gf::GF<2>>{0, 1, 1},
    std::vector<gf::GF<2>>{1},
}};

GF2Polynomial encode(const GF2Polynomial& code) {
  if (code.size() > 4) {
    throw CodeTooLongException();
  }

  return code * generatorPolynomial;
}

GF2Polynomial decode(GF2Polynomial& code) {
  if (code.size() > 7) {
    throw CodeTooLongException();
  }

  const GF2Polynomial remainder = code % generatorPolynomial;

  if (remainder.size() > 0) {
    const auto errorPos =
        std::find(remainderTable.begin(), remainderTable.end(), remainder);

    if (errorPos != remainderTable.end()) {
      const auto errorIdx = std::distance(remainderTable.begin(), errorPos);

      code[errorIdx] = code[errorIdx] + gf::GF<2>(1);
    } else {
      throw TwoErrorsException();
    }
  }

  const GF2Polynomial result = code / generatorPolynomial;

  return result;
}

}  // namespace hamming
