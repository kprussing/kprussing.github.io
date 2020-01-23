%{
#include <cstdio>

#include "parser.parser.hh"

%}

%option noyywrap

SIGN        [-+]
DIGIT       [0-9]
INTEGER     {SIGN}?{DIGIT}+
EXP         [eE]{SIGN}?{DIGIT}+
FLOAT       {SIGN}?(({DIGIT}+\.{DIGIT}*|{DIGIT}*\.{DIGIT}+){EXP}?|{DIGIT}+{EXP})
COMMENT     #

%%

[ \t\r]     ;
\n          ;
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

%%

