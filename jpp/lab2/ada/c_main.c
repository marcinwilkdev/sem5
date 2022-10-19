#include <stdio.h>

typedef struct ExtendedEuclideanResult
{
  int is_result;
  int first_number;
  int second_number;
} ExtendedEuclideanResult;

extern int gcd(int first_number, int second_number);
extern size_t factorial(size_t number);
extern ExtendedEuclideanResult extended_euclidean(int first_number, int second_number, int third_number);

extern int gcd_req(int first_number, int second_number);
extern size_t factorial_req(size_t number);
extern ExtendedEuclideanResult extended_euclidean_req(int first_number, int second_number, int third_number);

int main(void)
{
  int result = gcd(1, 1);
  size_t result_a = factorial(5);
  ExtendedEuclideanResult extended_euclidean_result = extended_euclidean(82, 12, 8);

  int result_req = gcd_req(1, 1);
  size_t result_a_req = factorial_req(5);
  ExtendedEuclideanResult extended_euclidean_result_req = extended_euclidean_req(82, 12, 8);

  printf("%d\n", result);
  printf("%zu\n", result_a);
  printf("%d %d\n", extended_euclidean_result.first_number, extended_euclidean_result.second_number);

  printf("%d\n", result_req);
  printf("%zu\n", result_a_req);
  printf("%d %d\n", extended_euclidean_result_req.first_number, extended_euclidean_result_req.second_number);
}
