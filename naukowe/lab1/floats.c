#include <stdlib.h>
#include <float.h>
#include <stdio.h>


int main(void)
{
    printf("Float epsilon: %.7e, Double epsilon: %.15e\n", FLT_EPSILON, DBL_EPSILON);
    printf("Float max: %.7e, Double max: %.15e\n", FLT_MAX, DBL_MAX);

    return EXIT_SUCCESS;
}
