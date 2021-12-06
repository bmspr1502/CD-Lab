%option noyywrap
%{
    #include<stdio.h>
    #include<stdlib.h> 
    #include "y.tab.h"
    extern int yylval;
%}
%% 
[0-9]+ {
yylval = yytext[0]-'0';
return (DIGIT); 
}
"+"|"-"|"*"|"/"|"("|")"|"\n" {
    return yytext[0];
} 
%%
