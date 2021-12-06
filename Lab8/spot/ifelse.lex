%option noyywrap
%{
    #include <stdio.h>
    #include "y.tab.h"
%}

alpha [a-zA-Z]
digit [0-9]

%%
[\t \n]
if { return IF; }
else { return ELSE; }
{digit}+ { return NUM; }
{alpha}({alpha}|{digit})* { return ID; }
"<=" { return LESSEREQUAL; }
">=" { return GREATEREQUAL; }
"==" { return EQUAL; }
"!=" { return NOTEQUAL; }
"||" { return OR; }
"&&" { return AND; }
.+; { return LINE; }
. { return yytext[0]; }
%%