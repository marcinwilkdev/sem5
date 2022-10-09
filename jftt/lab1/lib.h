#ifndef LIB_H
#define LIB_H

#include <stdlib.h>


typedef int matcherFunc(size_t, const unsigned char*, size_t, const unsigned char*, size_t*);

#define BUFFER_LEN 1024


int searchWithMatcher(int argc, const char* argv[argc + 1], matcherFunc* matcher_p);

#endif
