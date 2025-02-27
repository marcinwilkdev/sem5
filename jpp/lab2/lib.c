#include <stdbool.h>
#include <stdio.h>
#include "lib.h"


size_t factorial(const size_t n)
{
  size_t factorialResult = 1;

  for (size_t factorialStep = 2; factorialStep <= n; ++factorialStep)
  {
    factorialResult *= factorialStep;
  }

  return factorialResult;
}


int gcd(int firstNumber, int secondNumber)
{
  if (firstNumber == 0 || secondNumber == 0)
  {
    return 0;
  }

  if (firstNumber < secondNumber)
  {
    const int tmp = firstNumber;
    firstNumber = secondNumber;
    secondNumber = tmp;
  }

  while (secondNumber != 0)
  {
    const int tmp = secondNumber;
    secondNumber = firstNumber % secondNumber;
    firstNumber = tmp;
  }

  return abs(firstNumber);
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
    result_p->first = 0;
    result_p->second = 0;

    return -1;
  }

  const int multiplier = thirdNumber / gcdResult;
  
  int firstCoefficient = 0;
  int secondCoefficient = 1;
  int remainder = secondNumber;
  
  int oldFirstCoefficient = 1;
  int oldSecondCoefficient = 0;
  int oldRemainder = firstNumber;

  while (remainder != 0)
  {
    const int quotient = oldRemainder / remainder;

    const int tmpRemainder = remainder;
    remainder = oldRemainder - quotient * remainder;
    oldRemainder = tmpRemainder;

    const int tmpFirstCoefficient = firstCoefficient;
    firstCoefficient = oldFirstCoefficient - quotient * firstCoefficient;
    oldFirstCoefficient = tmpFirstCoefficient;

    const int tmpSecondCoefficient = secondCoefficient;
    secondCoefficient = oldSecondCoefficient - quotient * secondCoefficient;
    oldSecondCoefficient = tmpSecondCoefficient;
  }

  oldFirstCoefficient *= multiplier;
  oldSecondCoefficient *= multiplier;

  if (flipped)
  {
    result_p->first = oldSecondCoefficient;
    result_p->second = oldFirstCoefficient;
  }
  else
  {
    result_p->first = oldFirstCoefficient;
    result_p->second = oldSecondCoefficient;
  }

  return 0;
}
