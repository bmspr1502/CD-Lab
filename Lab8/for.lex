%{
    #include "y.tab.h"
%}

num [0-9]+
id [a-zA-Z]+
binaryoperator =|<|>|!=|<=|>=|==|&&|"||"|[+-/*]
unaryoperator "++"|"--"

%%
"for" {return FOR;}
{binaryoperator} {return BINARYOP;}
{unaryoperator} {return UNARYOP;}
{num} {return NUMBER;}
{id} {return ID;}
[ \n\t] ;
. {return *yytext;}
%%

int yywrap(){
    return 1;
    }
