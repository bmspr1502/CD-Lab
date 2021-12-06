%option noyywrap
%{    
    //2019103555
    /*
        2. b. Validate construct for "for" program
    */
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
"if" return IF;
{alpha}({alpha}|{digit})* return IDENTIFIER;
"<=" return LESSEQUAL;
">=" return GREATEREQUAL;
"==" return EQUAL;
"!=" return NOTEQUAL;
"||" return OR;
"&&" return AND;
. return yytext[0];
%%