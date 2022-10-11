#ifndef KMP_H
#define KMP_H

#include <stdlib.h>
#include "lib.h"


SearchResultE kmpSearch(size_t patternLen,
                        const unsigned char pattern[patternLen],
                        size_t textLen,
                        const unsigned char text[textLen],
                        size_t* patternStart_p);

#endif
