%{
#include <cstdio>
extern int yylex(void);
%}
%option noyywrap

SIGN        [-+]
DIGIT       [0-9]
INTEGER     {SIGN}?{DIGIT}+
EXP         [eE]{SIGN}?{DIGIT}+
FLOAT       {SIGN}?(({DIGIT}+\.{DIGIT}*|{DIGIT}*\.{DIGIT}+){EXP}?|{DIGIT}+{EXP})
COMMENT     #

%%

[ \t\r\n]   ;
{COMMENT}.* ;
{INTEGER}   {
        printf("Found the integer: %s\n", yytext);
    }
{FLOAT}     {
        printf("Found the float: %s\n", yytext);
    }
[A-Za-z0-9_-]+   {
        printf("Found the string: '%s'\n", yytext);
    }

%%
int main(int, char **)
{
    while (yylex());
    return 0;
}
