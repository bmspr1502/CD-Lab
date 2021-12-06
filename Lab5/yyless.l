%option noyywrap
%{
	#include<stdio.h>
%}

%%
[a-z]+ {
	printf("\n Lower ="); ECHO;
	yyless(3);
	printf("\nThe word after yyless() = "); ECHO;
}
[a-zA-Z]+ {
	printf("\nMixed letter is = "); ECHO;
}
%%

int main()
{
	yylex();
	return 0;
}