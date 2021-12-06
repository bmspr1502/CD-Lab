%option noyywrap
%{
	#include<stdio.h>

%}

%%
^[+-]?[0-9]+$ {
	printf("%s is a string with given conditions.\n", yytext);
}
.* {
	printf("%s is not matching.\n",yytext);
}
%%
int main(){
	yylex();
	return 0;
}