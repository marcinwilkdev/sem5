#include "cpp.hpp"
#include <catch2/catch_test_macros.hpp>

TEST_CASE("GF Creation test") {
  CHECK_THROWS_AS(cpp::GF(-1), cpp::GFNegativeException);
  CHECK_THROWS_AS(cpp::GF(1234567891), cpp::GFTooBigException);
  CHECK_NOTHROW(cpp::GF(50));
}

TEST_CASE("GF Addition test") {
  cpp::GF gf1 = cpp::GF(50);
  cpp::GF gf2 = cpp::GF(50);

  gf1 = gf1 + gf2;

  CHECK(gf1 == cpp::GF(100));

  gf1 = cpp::GF(1234567890);
  gf2 = cpp::GF(1);

  gf1 = gf1 + gf2;

  CHECK(gf1 == cpp::GF(0));

  gf1 = cpp::GF(1234567890);
  gf2 = cpp::GF(1);
  cpp::GF gf3 = cpp::GF(10);

  gf1 = gf1 + gf2 + gf3;

  CHECK(gf1 == cpp::GF(10));
}

TEST_CASE("GF Subtraction test") {
  cpp::GF gf1 = cpp::GF(51);
  cpp::GF gf2 = cpp::GF(50);

  gf1 = gf1 - gf2;

  CHECK(gf1 == cpp::GF(1));

  gf1 = cpp::GF(50);
  gf2 = cpp::GF(51);

  gf1 = gf1 - gf2;

  CHECK(gf1 == cpp::GF(1234567890));

  gf1 = cpp::GF(50);
  gf2 = cpp::GF(51);
  cpp::GF gf3 = cpp::GF(10);

  gf1 = gf1 - gf2;
  gf1 = gf1 - gf3;

  CHECK(gf1 == cpp::GF(1234567880));
}

TEST_CASE("GF Multiplication test") {
  cpp::GF gf1 = cpp::GF(50);
  cpp::GF gf2 = cpp::GF(50);

  gf1 = gf1 * gf2;

  CHECK(gf1 == cpp::GF(2500));

  gf1 = cpp::GF(1234567890);
  gf2 = cpp::GF(2);

  gf1 = gf1 * gf2;

  CHECK(gf1 == cpp::GF(1234567889));

  gf1 = cpp::GF(1234567890);
  gf2 = cpp::GF(2);
  cpp::GF gf3 = cpp::GF(2);

  gf1 = gf1 * gf2;
  gf1 = gf1 * gf3;
  CHECK(gf1 == cpp::GF(1234567887));
}

TEST_CASE("GF Division test") {
  cpp::GF gf1 = cpp::GF(100);
  cpp::GF gf2 = cpp::GF(50);

  gf1 = gf1 / gf2;

  CHECK(gf1 == cpp::GF(2));

  gf1 = cpp::GF(100);
  gf2 = cpp::GF(3);

  gf1 = gf1 / gf2;

  CHECK(gf1 == cpp::GF(33));

  gf1 = cpp::GF(100);
  gf2 = cpp::GF(3);
  cpp::GF gf3 = cpp::GF(3);

  gf1 = gf1 / gf2;
  gf1 = gf1 / gf3;

  CHECK(gf1 == cpp::GF(11));

  CHECK_THROWS_AS((gf1 / cpp::GF(0)), cpp::GFInverseOfZeroException);

  CHECK(gf1 < cpp::GF(100));
  CHECK(gf1 > cpp::GF(0));
}
