#ifndef LIB_H
#define LIB_H


#include <stdlib.h>


typedef struct PairS PairS;

struct PairS
{
  int first;
  int second;
};


size_t factorial(size_t n);
int gcd(int firstNumber, int secondNumber);
void extendedEuclidean(int firstNumber, int secondNumber, PairS* result);


#endif
