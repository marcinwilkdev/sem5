#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "lib_req.h"


static void factorialTest(void);
static void gcdTest(void);
static void extendedEuclideanTest(void);

static inline void extendedEuclideanTestNoZeros(int firstNumber, int secondNumber, int thirdNumber);
static inline void extendedEuclideanTestZeros(void);
static inline void extendedEuclideanTestNoResults(int firstNumber, int secondNumber, int thirdNumber);


int main(void)
{
  factorialTest();
  gcdTest();
  extendedEuclideanTest();

  puts("All tests passed.");

  return EXIT_SUCCESS;
}


static void factorialTest(void)
{
  assert(factorial(0) == 1);
  assert(factorial(1) == 1);
  assert(factorial(5) == 120);
  assert(factorial(10) == 3628800);
  assert(factorial(15) == 1307674368000);
}


static void gcdTest(void)
{
  assert(gcd(0, 0) == 0);
  assert(gcd(1, 0) == 0);
  assert(gcd(0, 1) == 0);

  assert(gcd(-52, 1) == 1);
  assert(gcd(1, 123) == 1);

  assert(gcd(147, 13) == 1);
  assert(gcd(-839, 60) == 1);

  assert(gcd(52, 13) == 13);

  assert(gcd(248, -94) == 2);
  assert(gcd(8, 6) == 2);
}


static void extendedEuclideanTest(void)
{
  extendedEuclideanTestNoZeros(82, 12, 8);
  extendedEuclideanTestNoZeros(12, 63, 12);
  extendedEuclideanTestNoZeros(8, 15, 19);
  extendedEuclideanTestNoZeros(1234, 432, 8);
  extendedEuclideanTestNoZeros(90, 5, 25);

  extendedEuclideanTestZeros();

  extendedEuclideanTestNoResults(82, 12, 1);
  extendedEuclideanTestNoResults(1234, 432, 9);
}


static inline void extendedEuclideanTestNoZeros(const int firstNumber, const int secondNumber, const int thirdNumber)
{
  PairS extendedEuclideanResult;
  assert(extendedEuclidean(firstNumber, secondNumber, thirdNumber, &extendedEuclideanResult) == 0);
  assert((firstNumber * extendedEuclideanResult.first +
          secondNumber * extendedEuclideanResult.second) ==
         thirdNumber);
}


static inline void extendedEuclideanTestZeros(void)
{
  PairS extendedEuclideanResult;
  assert(extendedEuclidean(0, 0, 0, &extendedEuclideanResult) == -1);
  assert(extendedEuclideanResult.first == 0 && extendedEuclideanResult.second == 0);
  assert(extendedEuclidean(1, 0, 0, &extendedEuclideanResult) == -1);
  assert(extendedEuclideanResult.first == 0 && extendedEuclideanResult.second == 0);
  assert(extendedEuclidean(0, 1, 0, &extendedEuclideanResult) == -1);
  assert(extendedEuclideanResult.first == 0 && extendedEuclideanResult.second == 0);
}


static inline void extendedEuclideanTestNoResults(int firstNumber, int secondNumber, int thirdNumber)
{
  PairS extendedEuclideanResult;
  assert(extendedEuclidean(firstNumber, secondNumber, thirdNumber, &extendedEuclideanResult) == -1);
}
