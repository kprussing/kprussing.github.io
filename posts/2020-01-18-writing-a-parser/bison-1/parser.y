%{
#include <cstdio>

// Flex details
extern int yylex(void);
extern int yyparse(void);
extern FILE * yyin;

void yyerror(const char * s);
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
    values
|   property values

values:
    value
|   values value

value:
    INT {
        printf("Found the integer %d\n", $1);
    }
|   FLOAT {
        printf("Found the float %g\n", $1);
    }
|   STRING {
        printf("Found the string '%s'\n", $1);
        free($1);
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
    fprintf(stderr, "Parsing error %s\n", s);
    exit(1);
}
