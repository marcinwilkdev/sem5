#include <string.h>
#include <stdbool.h>
#include <limits.h>
#include <stdio.h>
#include "fa.h"


#define BYTE_CAPACITY (UCHAR_MAX + 1)


static void parsePattern(const unsigned char* pattern_p, size_t maxMatched, size_t* lookupTable_p);
static inline bool prefixMatchedPostfix(const unsigned char* pattern_p,
                                        size_t newMatched,
                                        const unsigned char* wordPattern_p,
                                        unsigned char byte);


SearchResultE faSearch(const size_t patternLen,
                       const unsigned char pattern_p[const patternLen],
                       const size_t textLen,
                       const unsigned char text_p[const textLen],
                       size_t* const patternStart_p)
{
    if (textLen == 0)
    {
        return PATTERN_NOT_FOUND;
    }

    if (patternLen == 0)
    {
        *patternStart_p = 0;
        return PATTERN_FOUND;
    }

    const size_t maxMatched = patternLen + 1;

    size_t* const lookupTable_p = calloc(maxMatched * BYTE_CAPACITY, sizeof(size_t));
    parsePattern(pattern_p, maxMatched, lookupTable_p);

    size_t matchedCount = 0;

    for (size_t textIdx = 0; textIdx < textLen; ++textIdx)
    {
        matchedCount = lookupTable_p[matchedCount * BYTE_CAPACITY + text_p[textIdx]];

        if (matchedCount == patternLen)
        {
            *patternStart_p = textIdx - patternLen + 1;
            free(lookupTable_p);
            return PATTERN_FOUND;
        }
    }

    free(lookupTable_p);
    return PATTERN_NOT_FOUND;
}


static void parsePattern(const unsigned char* const pattern_p,
                        const size_t maxMatched,
                        size_t* const lookupTable_p)
{
    for (size_t matched = 0; matched < maxMatched - 1; ++matched)
    {
        for (size_t byte = 0; byte < BYTE_CAPACITY; ++byte)
        {
            const size_t maxNewMatched = matched + 1;

            for (size_t wordIdx = 0; wordIdx < maxNewMatched; ++wordIdx)
            {
                const size_t newMatched = maxNewMatched - wordIdx;
                const unsigned char* const newMatchedSuffix_p = &pattern_p[wordIdx];

                if (prefixMatchedPostfix(pattern_p, newMatched, newMatchedSuffix_p, byte))
                {
                    lookupTable_p[matched * BYTE_CAPACITY + byte] = newMatched;
                    break;
                }
            }
        }
    }
}


static inline bool prefixMatchedPostfix(const unsigned char* const pattern_p,
                                        const size_t newMatched,
                                        const unsigned char* const wordPattern_p,
                                        const unsigned char byte)
{
    return (byte == pattern_p[newMatched - 1]) &&
           (memcmp(pattern_p, wordPattern_p, sizeof(unsigned char[newMatched - 1])) == 0);
}
