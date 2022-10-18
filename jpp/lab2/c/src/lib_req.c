#include <stdbool.h>
#include "lib_req.h"


typedef struct ExtendedEuclideanS ExtendedEuclideanS;

struct ExtendedEuclideanS
{
  int firstCoefficient;
  int secondCoefficient;
  int remainder;
  int oldFirstCoefficient;
  int oldSecondCoefficient;
  int oldRemainder;
};


static int gcdReq(int firstNumber, int secondNumber);
static size_t factorialReq(size_t n, size_t acc);
static void extendedEuclideanReq(ExtendedEuclideanS* extendedEuclideanData_p);


size_t factorial(const size_t n)
{
  return factorialReq(n, 1);
}


int gcd(const int firstNumber, const int secondNumber)
{
  if (firstNumber == 0 || secondNumber == 0)
  {
    return 0;
  }

  if (firstNumber < secondNumber)
  {
    return abs(gcdReq(secondNumber, firstNumber));
  }
  else
  {
    return abs(gcdReq(firstNumber, secondNumber));
  }
}


int extendedEuclidean(int firstNumber, int secondNumber, int thirdNumber, PairS* const result_p)
{
  if (firstNumber == 0 || secondNumber == 0 || thirdNumber == 0)
  {
    result_p->first = 0;
    result_p->second = 0;

    return -1;
  }

  bool flipped = false;

  if (firstNumber < secondNumber)
  {
    const int tmpNumber = firstNumber;
    firstNumber = secondNumber;
    secondNumber = tmpNumber;

    flipped = true;
  }

  const int gcdResult = gcd(firstNumber, secondNumber);

  if (thirdNumber % gcdResult != 0)
  {
    return -1;
  }

  const int multiplier = thirdNumber / gcdResult;

  ExtendedEuclideanS extendedEuclideanData =
  {
    .firstCoefficient = 0,
    .secondCoefficient = 1,
    .remainder = secondNumber,
    .oldFirstCoefficient = 1,
    .oldSecondCoefficient = 0,
    .oldRemainder = firstNumber,
  };

  extendedEuclideanReq(&extendedEuclideanData);

  extendedEuclideanData.oldFirstCoefficient *= multiplier;
  extendedEuclideanData.oldSecondCoefficient *= multiplier;

  if (flipped)
  {
    result_p->first = extendedEuclideanData.oldSecondCoefficient;
    result_p->second = extendedEuclideanData.oldFirstCoefficient;
  }
  else
  {
    result_p->first = extendedEuclideanData.oldFirstCoefficient;
    result_p->second = extendedEuclideanData.oldSecondCoefficient;
  }

  return 0;
}


static int gcdReq(const int firstNumber, const int secondNumber)
{
  if (secondNumber == 0)
  {
    return firstNumber;
  }

  return gcdReq(secondNumber, firstNumber % secondNumber);
}


static size_t factorialReq(const size_t n, const size_t acc)
{
  if (n == 0)
  {
    return acc;
  }

  return factorialReq(n - 1, n * acc);
}


static void extendedEuclideanReq(ExtendedEuclideanS* const extendedEuclideanData_p)
{
  if (extendedEuclideanData_p->remainder == 0)
  {
    return;
  }

  const int quotient = extendedEuclideanData_p->oldRemainder / extendedEuclideanData_p->remainder;

  const int tmpRemainder = extendedEuclideanData_p->remainder;
  extendedEuclideanData_p->remainder = extendedEuclideanData_p->oldRemainder - quotient * extendedEuclideanData_p->remainder;
  extendedEuclideanData_p->oldRemainder = tmpRemainder;

  const int tmpFirstCoefficient = extendedEuclideanData_p->firstCoefficient;
  extendedEuclideanData_p->firstCoefficient = extendedEuclideanData_p->oldFirstCoefficient - quotient * extendedEuclideanData_p->firstCoefficient;
  extendedEuclideanData_p->oldFirstCoefficient = tmpFirstCoefficient;

  const int tmpSecondCoefficient = extendedEuclideanData_p->secondCoefficient;
  extendedEuclideanData_p->secondCoefficient = extendedEuclideanData_p->oldSecondCoefficient - quotient * extendedEuclideanData_p->secondCoefficient;
  extendedEuclideanData_p->oldSecondCoefficient = tmpSecondCoefficient;

  extendedEuclideanReq(extendedEuclideanData_p);
}
