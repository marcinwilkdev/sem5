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

    FILE* const textFile = fopen(argv[2], "r");

    if (textFile == NULL)
    {
        fprintf(stderr, "File %s doesn't exist.\n", argv[2]);
        return EXIT_FAILURE;
    }

    const size_t patternLen = strlen(argv[1]);
    const uint8_t* const pattern = (uint8_t*)argv[1];

    char buffer[BUFFER_LEN];
    size_t lineCounter = 0;

    while (fgets(buffer, BUFFER_LEN, textFile) != NULL)
    {
        const size_t textLen = strlen(buffer);
        const uint8_t* text = (uint8_t*)buffer;

        size_t offset = 0;
        size_t patternStart;

        while (faSearch(patternLen, pattern, textLen - offset, &text[offset], &patternStart) == 0)
        {
            printf("%zu:%zu\t%s", lineCounter, offset + patternStart, buffer);
            offset += patternStart + 1;
        }

        ++lineCounter;
    }

    fclose(textFile);

    return EXIT_SUCCESS;
}
