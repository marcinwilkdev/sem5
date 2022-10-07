#include <string.h>
#include <inttypes.h>
#include <stdbool.h>
#include <stdio.h>
#include "fa.h"


#define BYTE_SIZE (1 << 8)


static void parsePattern(const uint8_t* pattern_p, size_t maxMatched, size_t* lookupTable_p);
static inline bool prefixMatchedPostfix(
    const uint8_t* pattern_p, size_t newMatched, const uint8_t* wordPattern_p, uint8_t byte);


int faSearch(const size_t patternLen,
             const uint8_t pattern_p[const patternLen],
             const size_t textLen,
             const uint8_t text_p[const textLen],
             size_t* const patternStart_p)
{
    if (patternLen == 0 && textLen > 0)
    {
        *patternStart_p = 0;
        return 0;
    }

    const size_t maxMatched = patternLen + 1;

    size_t* const lookupTable_p = calloc(maxMatched * BYTE_SIZE, sizeof(size_t));
    parsePattern(pattern_p, maxMatched, lookupTable_p);

    size_t matchedCount = 0;

    for (size_t textIdx = 0; textIdx < textLen; ++textIdx)
    {
        matchedCount = lookupTable_p[matchedCount * BYTE_SIZE + text_p[textIdx]];

        if (matchedCount == patternLen)
        {
            *patternStart_p = textIdx - patternLen + 1;
            free(lookupTable_p);
            return 0;
        }
    }

    free(lookupTable_p);
    return -1;
}


static void parsePattern(const uint8_t* const pattern_p,
                        const size_t maxMatched,
                        size_t* const lookupTable_p)
{
    for (size_t matched = 0; matched < maxMatched - 1; ++matched)
    {
        for (size_t byte = 0; byte < BYTE_SIZE; ++byte)
        {
            const size_t maxNewMatched = matched + 1;

            for (size_t wordIdx = 0; wordIdx < maxNewMatched; ++wordIdx)
            {
                const size_t newMatched = maxNewMatched - wordIdx;
                const uint8_t* const newMatchedSuffix_p = &pattern_p[wordIdx];

                if (prefixMatchedPostfix(pattern_p, newMatched, newMatchedSuffix_p, byte))
                {
                    lookupTable_p[matched * BYTE_SIZE + byte] = newMatched;
                    break;
                }
            }
        }
    }
}


static inline bool prefixMatchedPostfix(const uint8_t* const pattern_p,
                                        const size_t newMatched,
                                        const uint8_t* const wordPattern_p,
                                        const uint8_t byte)
{
    if (byte == pattern_p[newMatched - 1])
    {
        for (size_t newMatchedIdx = 0; newMatchedIdx < newMatched - 1; ++newMatchedIdx)
        {
            if (pattern_p[newMatchedIdx] != wordPattern_p[newMatchedIdx])
            {
                return false;
            }
        }

        return true;
    }

    return false;
}
