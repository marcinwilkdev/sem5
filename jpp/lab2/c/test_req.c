#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "lib_req.h"


static void factorialTest(void);
static void gcdTest(void);
static void extendedEuclideanTest(void);

static inline void extendedEuclideanTestNoZeros(int firstNumber, int secondNumber);
static inline void extendedEuclideanTestZeros(void);


int main(void)
{
  factorialTest();
  gcdTest();

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
  extendedEuclideanTestNoZeros(82, 12);
  extendedEuclideanTestNoZeros(12, 63);
  extendedEuclideanTestNoZeros(8, 15);
  extendedEuclideanTestNoZeros(1234, 432);
  extendedEuclideanTestNoZeros(90, 5);

  extendedEuclideanTestZeros();
}


static inline void extendedEuclideanTestNoZeros(const int firstNumber, const int secondNumber)
{
  PairS extendedEuclideanResult;
  extendedEuclidean(firstNumber, secondNumber, &extendedEuclideanResult);
  assert((firstNumber * extendedEuclideanResult.first +
          secondNumber * extendedEuclideanResult.second) ==
         gcd(firstNumber, secondNumber));
  printf("Passed for (%d, %d)\n", firstNumber, secondNumber);
}


static inline void extendedEuclideanTestZeros(void)
{
  PairS extendedEuclideanResult;
  extendedEuclidean(0, 0, &extendedEuclideanResult);
  assert(extendedEuclideanResult.first == 0 && extendedEuclideanResult.second == 0);
  extendedEuclidean(1, 0, &extendedEuclideanResult);
  assert(extendedEuclideanResult.first == 0 && extendedEuclideanResult.second == 0);
  extendedEuclidean(0, 1, &extendedEuclideanResult);
  assert(extendedEuclideanResult.first == 0 && extendedEuclideanResult.second == 0);
}
