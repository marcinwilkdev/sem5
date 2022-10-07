#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

#include "fa.h"

int main(void)
{
    const char* pattern_p = "test";
    const char* text_p = "This is a test.";
    size_t matchedIndex = 0;
    size_t expected = 10;

    assert(faSearch(pattern_p, text_p, &matchedIndex) == 0);
    assert(expected == matchedIndex);


    pattern_p = "Test";
    text_p = "This is a test.";

    assert(faSearch(pattern_p, text_p, &matchedIndex) == -1);


    pattern_p = "TeTest";
    text_p = "This is a TeTeTest.";
    expected = 12;

    assert(faSearch(pattern_p, text_p, &matchedIndex) == 0);
    assert(expected == matchedIndex);


    pattern_p = "";
    text_p = "This is a test.";
    expected = 0;

    assert(faSearch(pattern_p, text_p, &matchedIndex) == 0);
    assert(expected == matchedIndex);


    pattern_p = "test";
    text_p = "";

    assert(faSearch(pattern_p, text_p, &matchedIndex) == -1);

    puts("All tests passed.");
}
