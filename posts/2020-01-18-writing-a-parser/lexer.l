%{
#include <cstdlib>
#include <cstdio>
#include <cstring>

#include "parser.hh"

int line_num = 1;
%}

%option noyywrap

SIGN        [-+]
DIGIT       [0-9]
INTEGER     {SIGN}?{DIGIT}+
EXP         [eE]{SIGN}?{DIGIT}+
FLOAT       {SIGN}?(({DIGIT}+\.{DIGIT}*|{DIGIT}*\.{DIGIT}+){EXP}?|{DIGIT}+{EXP})
COMMENT     #
SEP         :

%%

[ \t\r]     ;
\n          {line_num++;}

string      { return string_type; }
scalar      { return scalar_type; }
vector      { return vector_type; }

{COMMENT}.* ;
{INTEGER}   {
        yylval.ival = atoi(yytext);
        return INT;
    }
{FLOAT}     {
        yylval.fval = atof(yytext);
        return FLOAT;
    }
[A-Za-z0-9_-]+   {
        yylval.sval = strdup(yytext);
        return STRING;
    }
{SEP}       {return SEP;}

%%

