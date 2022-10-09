#ifndef FA_H
#define FA_H

#include <stdlib.h>


int faSearch(size_t patternLen,
             const unsigned char pattern[patternLen],
             size_t textLen,
             const unsigned char text[textLen],
             size_t* patternStart_p);


#endif
