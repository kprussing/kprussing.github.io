#include <cstdio>
#include <iostream>

#include "database.hpp"

int main(int argc, char* argv[])
{
    if (argc != 2)
    {
        std::cerr << "Input file required!" << std::endl;
        return EXIT_FAILURE;
    }

    // Open the file and make sure it's valid
    FILE * myfile = fopen(argv[1], "r");
    if (!myfile)
    {
        std::cout << "I can't open " << argv[0] << "!" << std::endl;
        return EXIT_FAILURE;
    }

    // Load the data
    load(myfile);

    std::cout << db;

    return 0;
}
  
