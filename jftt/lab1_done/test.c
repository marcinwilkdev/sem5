#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <string.h>
#include "fa.h"
#include "kmp.h"


typedef int matcherFunc(size_t, const uint8_t*, size_t, const uint8_t*, size_t*);


static void matcherTests(matcherFunc* matcher);


int main(void)
{
    matcherTests(faSearch);
    matcherTests(kmpSearch);

    puts("All tests passed.");
}


static void matcherTests(matcherFunc* const matcher)
{
    const char* pattern_p = "test";
    const char* text_p = "This is a test.";

    size_t patternLen = strlen(pattern_p);
    size_t textLen = strlen(text_p);

    size_t matchedIndex = 0;
    size_t expected = 10;

    assert(matcher(patternLen, (uint8_t*)pattern_p, textLen, (uint8_t*)text_p, &matchedIndex) == 0);
    assert(expected == matchedIndex);

    pattern_p = "Test";
    text_p = "This is a test.";

    patternLen = strlen(pattern_p);
    textLen = strlen(text_p);

    assert(matcher(patternLen, (uint8_t*)pattern_p, textLen, (uint8_t*)text_p, &matchedIndex) == -1);
    assert(expected == matchedIndex);

    pattern_p = "TeTest";
    text_p = "This is a TeTeTest.";

    patternLen = strlen(pattern_p);
    textLen = strlen(text_p);

    expected = 12;

    assert(matcher(patternLen, (uint8_t*)pattern_p, textLen, (uint8_t*)text_p, &matchedIndex) == 0);
    assert(expected == matchedIndex);

    pattern_p = "";
    text_p = "This is a test.";

    patternLen = strlen(pattern_p);
    textLen = strlen(text_p);

    expected = 0;

    assert(matcher(patternLen, (uint8_t*)pattern_p, textLen, (uint8_t*)text_p, &matchedIndex) == 0);
    assert(expected == matchedIndex);

    pattern_p = "test";
    text_p = "";

    patternLen = strlen(pattern_p);
    textLen = strlen(text_p);

    assert(matcher(patternLen, (uint8_t*)pattern_p, textLen, (uint8_t*)text_p, &matchedIndex) == -1);
    assert(expected == matchedIndex);
}
