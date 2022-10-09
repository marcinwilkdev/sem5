#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "fa.h"


#define BUFFER_LEN 1024


int main(const int argc, const char* const argv[argc + 1])
{
    if (argc < 3)
    {
        fprintf(stderr, "You have to provide pattern and file.\n");
        return EXIT_FAILURE;
    }

    const char* const query_p = argv[1];
    const char* const fileName_p = argv[2];

    FILE* const textFile_p = fopen(fileName_p, "r");

    if (textFile_p == NULL)
    {
        fprintf(stderr, "File %s doesn't exist.\n", fileName_p);
        return EXIT_FAILURE;
    }

    const size_t patternLen = strlen(query_p);
    const unsigned char* const pattern_p = (unsigned char*)query_p;

    char buffer[BUFFER_LEN];
    size_t lineCounter = 0;

    while (fgets(buffer, BUFFER_LEN, textFile_p) != NULL)
    {
        const size_t textLen = strlen(buffer);
        const unsigned char* text_p = (unsigned char*)buffer;

        size_t matchOffset = 0;
        size_t matchIndex;

        while (faSearch(patternLen,
                        pattern_p,
                        textLen - matchOffset,
                        &text_p[matchOffset],
                        &matchIndex) == 0)
        {
            printf("%zu:%zu\t%s", lineCounter, matchOffset + matchIndex, buffer);
            matchOffset += matchIndex + 1;
        }

        ++lineCounter;
    }

    fclose(textFile_p);

    return EXIT_SUCCESS;
}
