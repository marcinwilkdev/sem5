#include "lib.h"
#include "fa.h"

int main(const int argc, const char* argv[const argc + 1])
{
    return searchWithMatcher(argc, argv, faSearch);
}
