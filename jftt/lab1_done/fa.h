#ifndef FA_H
#define FA_H


#include <stdlib.h>
#include <inttypes.h>


int faSearch(size_t patternLen,
             const uint8_t pattern[patternLen],
             size_t textLen,
             const uint8_t text[textLen],
             size_t* patternStart_p);


#endif
