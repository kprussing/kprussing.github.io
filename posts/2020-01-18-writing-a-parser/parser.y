%{
#include <algorithm>
#include <cctype>
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

size_t n_cols;
size_t n_rows;

%}

%code requires {
#include "database.hpp"
}

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
%token <sval> SEP

%token <sval> scalar_type
%token <sval> vector_type
%token <sval> string_type

%%

file:
    /* empty */
|   file property 

property:
    STRING SEP {
        key.assign($1);
        free($1);
        std::transform(key.begin(), key.end(), key.begin(),
                       [](unsigned char c)->int { return tolower(c); });
    } data

data:
    scalar
|   string
|   vector

string:
    string_type SEP STRING {
        db[key] = Datum();
        db[key].type = Datum::String;
        db[key].value.assign($3);
        free($3);
    }

scalar:
    /* empty */ {
        n_rows = 1;
        n_cols = 1;
        data.clear();
    } values 
|   scalar_type SEP {
        n_rows = 1;
        n_cols = 1;
        data.clear();
    } values 
|   scalar_type SEP INT SEP {
        n_rows = 1;
        n_cols = $3;
        data.clear();
    } values 

vector:
    vector_type SEP {
        n_rows = 0;
        n_cols = 0;
        data.clear();
    } values 
|   vector_type SEP INT SEP {
        n_rows = $3;
        n_cols = 0;
        data.clear();
    } values 
|   vector_type SEP INT SEP INT SEP {
        n_rows = $3;
        n_cols = $5;
        data.clear();
    } values 

values:
    _values {
        size_t len = n_rows * n_cols;
        if (len > 0 && data.size() != len) {
            std::cout << "Size miss-match! Read " << data.size()
                << " instead of " << len << "entries" << std::endl;
        }
        /*std::cout << key << ": ";*/
        /*for (auto d: data) std::cout << " " << d;*/
        /*std::cout << std::endl;*/
        db[key] = Datum();
        if (n_rows == 1)
            db[key].type = Datum::Scalar;
        else
            db[key].type = Datum::Vector;

        db[key].data.resize(n_rows, std::vector<float>(n_cols, 0));
        for (int i = 0, k = 0; i < n_rows; i++, k++)
            for (int j = 0; j < n_cols; j++, k++)
                db[key].data[i][j] = data[k];
    }

_values:
    value
|   _values value

value:
    INT {
        data.push_back($1);
    }
|   FLOAT {
        data.push_back($1);
    }

%%

void yyerror(const char * s)
{
    fprintf(stderr, "Parsing error %s at %d\n", s, line_num);
    /*exit(1);*/
}
