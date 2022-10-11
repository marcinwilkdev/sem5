#include <stdio.h>
#include "kmp.h"


static void computePrefixFunction(size_t patternLen,
                                  const unsigned char pattern[patternLen],
                                  size_t prefixFunction[patternLen + 1]);


SearchResultE kmpSearch(const size_t patternLen,
                        const unsigned char pattern[const patternLen],
                        const size_t textLen,
                        const unsigned char text[const textLen],
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

    size_t prefixFunction[patternLen + 1];

    computePrefixFunction(patternLen, pattern, prefixFunction);

    size_t matched = 0;

    for (size_t textIdx = 0; textIdx < textLen; ++textIdx)
    {
        while (matched > 0 && (pattern[matched] != text[textIdx]))
        {
            matched = prefixFunction[matched];
        }

        if (pattern[matched] == text[textIdx])
        {
            ++matched;
        }

        if (matched == patternLen)
        {
            *patternStart_p = textIdx - patternLen + 1;
            return PATTERN_FOUND;
        }
    }

    return PATTERN_NOT_FOUND;
}


static void computePrefixFunction(const size_t patternLen,
                                  const unsigned char pattern[const patternLen],
                                  size_t prefixFunction[const patternLen + 1])
{
    prefixFunction[0] = 0;
    prefixFunction[1] = 0;

    size_t newMatched = 0;

    for (size_t matched = 2; matched < patternLen + 1; ++matched)
    {
        while (newMatched > 0 && (pattern[newMatched] != pattern[matched - 1]))
        {
            newMatched = prefixFunction[newMatched];
        }

        if (pattern[newMatched] == pattern[matched - 1])
        {
            ++newMatched;
        }

        prefixFunction[matched] = newMatched;
    }
}
