#ifndef LIB_H
#define LIB_H

#include <stdlib.h>


#define BUFFER_LEN 1024


typedef enum SearchResultE
{
    PATTERN_FOUND,
    PATTERN_NOT_FOUND,
} SearchResultE;


typedef SearchResultE matcherFunc(size_t,
                                  const unsigned char*,
                                  size_t,
                                  const unsigned char*,
                                  size_t*);


int searchWithMatcher(int argc, const char* argv[argc + 1], matcherFunc* matcher_p);

#endif
