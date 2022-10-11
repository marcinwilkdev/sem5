#include <stdio.h>
#include <string.h>
#include "lib.h"


#define BUFFER_SIZE 8000000


int searchWithMatcher(const int argc, const char* argv[const argc + 1], matcherFunc* const matcher_p)
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

    unsigned char* const fileContent_p = malloc(sizeof(unsigned char[BUFFER_SIZE]));

    const size_t textLen = fread(fileContent_p, sizeof(unsigned char), BUFFER_SIZE, textFile_p);

    size_t matchOffset = 0;
    size_t matchIndex;

    size_t utf8Idx = 0;
    size_t textIdx = 0;

    printf("[");

    while (matcher_p(patternLen,
                     pattern_p,
                     textLen - matchOffset,
                     &fileContent_p[matchOffset],
                     &matchIndex) == 0)
    {
        while (textIdx < matchOffset + matchIndex)
        {
            if ((fileContent_p[textIdx] & 0xf8) == 0xf0) 
            {
                textIdx += 4;
            }
            else if ((fileContent_p[textIdx] & 0xf0) == 0xe0)
            {
                textIdx += 3;
            }
            else if ((fileContent_p[textIdx] & 0xe0) == 0xc0)
            {
                textIdx += 2;
            }
            else
            {
                textIdx += 1;
            }

            ++utf8Idx;
        }

        printf("%zu, ", utf8Idx);

        matchOffset += matchIndex + 1;
    }

    if (matchOffset > 0)
    {
        printf("\b\b");
    }

    printf("]\n");

    // char buffer[BUFFER_LEN];
    // size_t lineCounter = 0;
    //
    // while (fgets(buffer, BUFFER_LEN, textFile_p) != NULL)
    // {
    //     const size_t textLen = strlen(buffer);
    //     const unsigned char* text_p = (unsigned char*)buffer;
    //
    //     size_t matchOffset = 0;
    //     size_t matchIndex;
    //
    //     while (matcher_p(patternLen,
    //                     pattern_p,
    //                     textLen - matchOffset,
    //                     &text_p[matchOffset],
    //                     &matchIndex) == 0)
    //     {
    //         // printf("%zu:%zu\t%s", lineCounter, matchOffset + matchIndex, buffer);
    //         printf("%zu:%zu\t", lineCounter, matchOffset + matchIndex);
    //         matchOffset += matchIndex + 1;
    //     }
    //
    //     ++lineCounter;
    // }

    free(fileContent_p);
    fclose(textFile_p);

    return EXIT_SUCCESS;
}
