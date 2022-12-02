#include <cstdlib>
#include <iostream>

#include "doubleWrapper.hpp"
#include "gf.hpp"
#include "hamming.hpp"
#include "polynomial.hpp"

int main(void) {
  {
    using DW = doubleWrapper::DoubleWrapper;

    auto pol1 = polynomial::Polynomial<DW>({DW(-1), DW(2), DW(0), DW(1)});
    auto pol2 = polynomial::Polynomial<DW>({DW(-1), DW(1)});

    std::cout << "pol1 = " << pol1 << '\n';
    std::cout << "pol2 = " << pol2 << '\n';

    auto pol3 = pol1 / pol2;
    auto pol4 = pol1 % pol2;
    auto pol5 = pol2 / pol1;
    auto pol6 = pol2 % pol1;

    std::cout << "pol1 / pol2 = " << pol3 << '\n';
    std::cout << "pol1 % pol2 = " << pol4 << '\n';
    std::cout << "pol2 / pol1 = " << pol5 << '\n';
    std::cout << "pol2 % pol1 = " << pol6 << '\n';

    auto result = pol1(DW(1));

    std::cout << "pol1(1) = " << result << '\n';
    std::cout << "First coeff = " << pol1[0] << '\n';
  }

  std::cout << '\n';

  {
    using GF = gf::GF<2>;

    auto pol1 = polynomial::Polynomial<GF>({GF(1), GF(0), GF(1), GF(1)});
    auto pol2 = polynomial::Polynomial<GF>({GF(1), GF(1)});

    std::cout << "pol1 = " << pol1 << '\n';
    std::cout << "pol2 = " << pol2 << '\n';

    auto pol3 = pol1 / pol2;
    auto pol4 = pol1 % pol2;
    auto pol5 = pol2 / pol1;
    auto pol6 = pol2 % pol1;

    std::cout << "pol1 / pol2 = " << pol3 << '\n';
    std::cout << "pol1 % pol2 = " << pol4 << '\n';
    std::cout << "pol2 / pol1 = " << pol5 << '\n';
    std::cout << "pol2 % pol1 = " << pol6 << '\n';

    auto result = pol1(GF(1));

    std::cout << "pol1(1) = " << result << '\n';
    std::cout << "First coeff = " << pol1[0] << '\n';
  }

  std::cout << '\n';

  {
    using GF = gf::GF<2>;

    auto code = polynomial::Polynomial<GF>({GF(1), GF(1), GF(1), GF(1)});

    std::cout << "code = " << code << '\n';

    auto encoded = hamming::encode(code);

    std::cout << "Encoded code = " << encoded << '\n';

    encoded[4] = encoded[4] + GF(1);

    auto decoded = hamming::decode(encoded);

    std::cout << "Decoded code = " << decoded << '\n';
  }

  return EXIT_SUCCESS;
}
