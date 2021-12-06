%option noyywrap
%{
    #include<stdio.h>
    #include "y.tab.h"
%}

alpha [A-Za-z]
digit [0-9]

%%
[\t \n]
printf[^;]* return PRINTF;
"int"|"float"|"char" return DTYPE;
for return FOR;
{digit}+ return NUMBER;
{alpha}({alpha}|{digit})* return IDENTIFIER;
"<=" return LESSEQUAL;
">=" return GREATEREQUAL;
"==" return EQUAL;
"!=" return NOTEQUAL;
"||" return OR;
"&&" return AND;
"{" return OPENBRACKET;
"}" return CLOSEBRACKET;
. return yytext[0];
%%