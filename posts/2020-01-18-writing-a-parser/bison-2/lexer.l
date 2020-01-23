%{
#include <cstdio>

#include "parser.parser.hh"

int line_num = 1;
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
\n          {line_num++;}
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
:           {return ':';}

%%

