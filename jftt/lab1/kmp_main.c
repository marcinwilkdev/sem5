#include "lib.h"
#include "kmp.h"

int main(const int argc, const char* argv[const argc + 1])
{
    return searchWithMatcher(argc, argv, kmpSearch);
}
