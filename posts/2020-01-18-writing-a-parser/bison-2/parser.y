%{
#include <iostream>
#include <string>
#include <vector>

// Flex details
extern int yylex(void);
extern int yyparse(void);
extern FILE * yyin;
extern "C" int line_num;

void yyerror(const char * s);

// Variables for tracking data
std::string key;
std::string val;
std::vector<float> data;
%}

// Define a union to extract the low level tokens from the lexer.
%union
{
    int     ival;
    float   fval;
    char *  sval;
}

// Define the "terminal symbol" token types I'm going to use (in CAPS
// by convention), and associate each with a field of the %union:
%token <ival> INT
%token <fval> FLOAT
%token <sval> STRING

%%

file:
    /* empty */
|   file property

property:
    STRING ':' {
        key.assign($1);
        free($1);
    } STRING {
        val.assign($4);
        free($4);
        std::cout << "String property: " << key << ":" << val
            << std::endl;
    }
|   STRING ':' {
        key.assign($1);
        free($1);
        data.clear();
    } values {
        std::cout << "Data property: " << key << ":";
        for (auto d: data)
            std::cout << " " << d;
        std::cout << std::endl;
    }

values:
    value
|   values value

value:
    INT {
        data.push_back($1);
    }
|   FLOAT {
        data.push_back($1);
    }

%%

int main(int, char**)
{
    // open a file handle to a particular file:
    const char * the_file = "../example.dat";
    FILE * myfile = fopen(the_file, "r");
    // make sure it's valid:
    if (!myfile)
    {
        printf("I can't open %s!\n", the_file);
        return -1;
    }

    // set lex to read from it instead of defaulting to STDIN:
    yyin = myfile;

    // Parse the inputs
    yyparse();

    return 0;
}
  
void yyerror(const char * s)
{
    fprintf(stderr, "Parsing error %s at %d\n", s, line_num);
    /*exit(1);*/
}
