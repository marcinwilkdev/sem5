#include <string.h>
#include <limits.h>
#include <stdbool.h>

#include "fa.h"


#define NUM_CHARS ((size_t)((int)CHAR_MAX - (int)CHAR_MIN))


static int createLookupTable(
    size_t patternLen, const char* pattern, size_t* lookupTable_p);
static inline size_t* lookupTableEntry(
    size_t* lookupTable_p, size_t matched, char character);
static inline bool suffixMatchesPrefix(
    const char* pattern_p,
    size_t matchedCount,
    size_t currMatchedCount,
    size_t character
);


int faSearch(const char* const pattern_p,
             const char* const text_p,
             size_t* const patternStart_p)
{
    const size_t patternLen = strlen(pattern_p);
    const size_t textLen = strlen(text_p);

    if (patternLen == 0 && textLen > 0) {
        *patternStart_p = 0;
        return 0;
    }

    size_t* lookupTable = malloc(sizeof(size_t[patternLen * NUM_CHARS]));

    createLookupTable(patternLen, pattern_p, lookupTable);

    size_t matched = 0;

    for (size_t textIdx = 0; textIdx < textLen; ++textIdx)
    {
        matched = *lookupTableEntry(lookupTable, matched, text_p[textIdx]);

        if (matched == patternLen)
        {
            *patternStart_p = textIdx - (patternLen - 1);

            free(lookupTable);
            return 0;
        }
    }

    free(lookupTable);
    return -1;
}


static int createLookupTable(const size_t patternLen,
                             const char* const pattern_p,
                             size_t* const lookupTable_p)
{
    for (size_t matchedCount = 0; matchedCount < patternLen; ++matchedCount)
    {
        for (size_t character = 0; character < NUM_CHARS; ++character)
        {
            size_t currMatchedCount = matchedCount + 1;

            while (currMatchedCount > 0 &&
                   !suffixMatchesPrefix(pattern_p,
                                        matchedCount,
                                        currMatchedCount,
                                        character))
            {
                --currMatchedCount;
            }

            *lookupTableEntry(
                lookupTable_p, matchedCount, character) = currMatchedCount;
        }
    }

    return 0;
}


static inline size_t* lookupTableEntry(size_t* const lookupTable_p,
                                       const size_t matched,
                                       const char character)
{
    // Prevents indexing by negative value if char is signed.
    const size_t characterIdx = (size_t)((int)character - (int)CHAR_MIN);

    return &lookupTable_p[matched * NUM_CHARS + characterIdx];
}


static inline bool suffixMatchesPrefix(
    const char* const pattern_p,
    const size_t matchedCount,
    const size_t currMatchedCount,
    const size_t character
)
{
    const size_t suffixOffset = matchedCount + 1 - currMatchedCount;

    if (pattern_p[currMatchedCount - 1] != character) {
        return false;
    }

    for (size_t patternIdx = 0;
         patternIdx < currMatchedCount - 1;
         ++patternIdx)
    {
        if (pattern_p[patternIdx] != pattern_p[suffixOffset + patternIdx])
        {
            return false;
        }
    }

    return true;
}
