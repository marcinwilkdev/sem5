#include <catch2/catch_test_macros.hpp>

#include "cpp.hpp"

TEST_CASE("GF Creation test") {
  CHECK_THROWS_AS(cpp::GF<1234567891>(-1), cpp::GFNegativeException);
  CHECK_THROWS_AS(cpp::GF<1234567891>(1234567891), cpp::GFTooBigException);
  CHECK_THROWS_AS(cpp::GF<1234567890>(1), cpp::GFNotPrimeException);
  CHECK_NOTHROW(cpp::GF<1234567891>(50));
}

TEST_CASE("GF<1234567891> Addition test") {
  cpp::GF gf1 = cpp::GF<1234567891>(50);
  cpp::GF gf2 = cpp::GF<1234567891>(50);

  gf1 = gf1 + gf2;

  CHECK(gf1 == cpp::GF<1234567891>(100));

  gf1 = cpp::GF<1234567891>(1234567890);
  gf2 = cpp::GF<1234567891>(1);

  gf1 = gf1 + gf2;

  CHECK(gf1 == cpp::GF<1234567891>(0));

  gf1 = cpp::GF<1234567891>(1234567890);
  gf2 = cpp::GF<1234567891>(1);
  cpp::GF<1234567891> gf3 = cpp::GF<1234567891>(10);

  gf1 = gf1 + gf2 + gf3;

  CHECK(gf1 == cpp::GF<1234567891>(10));
}

TEST_CASE("GF<1234567891> Subtraction test") {
  cpp::GF gf1 = cpp::GF<1234567891>(51);
  cpp::GF gf2 = cpp::GF<1234567891>(50);

  gf1 = gf1 - gf2;

  CHECK(gf1 == cpp::GF<1234567891>(1));

  gf1 = cpp::GF<1234567891>(50);
  gf2 = cpp::GF<1234567891>(51);

  gf1 = gf1 - gf2;

  CHECK(gf1 == cpp::GF<1234567891>(1234567890));

  gf1 = cpp::GF<1234567891>(50);
  gf2 = cpp::GF<1234567891>(51);
  cpp::GF gf3 = cpp::GF<1234567891>(10);

  gf1 = gf1 - gf2;
  gf1 = gf1 - gf3;

  CHECK(gf1 == cpp::GF<1234567891>(1234567880));
}

TEST_CASE("GF<1234567891> Multiplication test") {
  cpp::GF gf1 = cpp::GF<1234567891>(50);
  cpp::GF gf2 = cpp::GF<1234567891>(50);

  gf1 = gf1 * gf2;

  CHECK(gf1 == cpp::GF<1234567891>(2500));

  gf1 = cpp::GF<1234567891>(1234567890);
  gf2 = cpp::GF<1234567891>(2);

  gf1 = gf1 * gf2;

  CHECK(gf1 == cpp::GF<1234567891>(1234567889));

  gf1 = cpp::GF<1234567891>(1234567890);
  gf2 = cpp::GF<1234567891>(2);
  cpp::GF gf3 = cpp::GF<1234567891>(2);

  gf1 = gf1 * gf2;
  gf1 = gf1 * gf3;
  CHECK(gf1 == cpp::GF<1234567891>(1234567887));
}

TEST_CASE("GF<1234567891> Inverse test") {
  CHECK(cpp::GF<1234567891>(100) * cpp::GF<1234567891>(100).inverse() ==
        cpp::GF<1234567891>(1));
  CHECK(cpp::GF<1234567891>(3) * cpp::GF<1234567891>(3).inverse() ==
        cpp::GF<1234567891>(1));
  CHECK(cpp::GF<1234567891>(28) * cpp::GF<1234567891>(28).inverse() ==
        cpp::GF<1234567891>(1));
  CHECK(cpp::GF<1234567891>(15) * cpp::GF<1234567891>(15).inverse() ==
        cpp::GF<1234567891>(1));
}

TEST_CASE("GF<1234567891> Division test") {
  cpp::GF gf1 = cpp::GF<1234567891>(100);
  cpp::GF gf2 = cpp::GF<1234567891>(50);

  gf1 = gf1 / gf2;

  CHECK(gf1 == cpp::GF<1234567891>(2));

  gf1 = cpp::GF<1234567891>(100);
  gf2 = cpp::GF<1234567891>(3);

  gf1 = gf1 / gf2;

  CHECK(gf1 == cpp::GF<1234567891>(823045294));

  gf1 = cpp::GF<1234567891>(100);
  gf2 = cpp::GF<1234567891>(3);
  cpp::GF gf3 = cpp::GF<1234567891>(3);

  gf1 = gf1 / gf2;
  gf1 = gf1 / gf3;

  CHECK(gf1 == cpp::GF<1234567891>(1097393692));

  CHECK_THROWS_AS((gf1 / cpp::GF<1234567891>(0)),
                  cpp::GFInverseOfZeroException);
}
