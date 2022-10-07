#include <stdlib.h>
#include <stdio.h>
#include "fa.h"


#define BUFFER_LEN 1024


int main(int argc, char* argv[argc + 1])
{
    if (argc < 3)
    {
        fprintf(stderr, "You have to provide pattern and file name.\n");
        return EXIT_FAILURE;
    }

    FILE* const textFile = fopen(argv[2], "r");

    if (textFile == NULL)
    {
        fprintf(stderr, "File %s doesn't exist.\n", argv[2]);
        return EXIT_FAILURE;
    }

    char buffer[BUFFER_LEN];
    size_t lineNumber = 0;

    // This works based on buffer having full text line ending with \n.
    // It also can't find multiple occurences in same line.
    // TODO: Change this so it's more robust.
    while (fgets(buffer, BUFFER_LEN, textFile) != NULL)
    {
        size_t patternStart;
        const char* searchStart = argv[1];

        while (faSearch(searchStart, buffer, &patternStart) == 0)
        {
            printf("%zu:%zu %s", lineNumber, patternStart, buffer);
            searchStart = &argv[1][patternStart + 1];
        }

        ++lineNumber;
    }

    fclose(textFile);

    return EXIT_SUCCESS;
}
