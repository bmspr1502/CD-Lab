%option noyywrap
%{
	#include<stdio.h>
%}

others [bcdfghjklmnpqrstvwxyz]
%%
{others}*a({others}|a)*e({others}|e)*i({others}|i)*o({others}|o)*u({others}|u)* {
	printf("%s, string is accepted.\n", yytext);
	}
.+ {
	printf("%s is not accepted. \n", yytext);
}
%%
int main()
{
//All  strings  of  lower  case  letters  that  contain  
//5 vowels in orders.
	yylex();
	return 0;
}