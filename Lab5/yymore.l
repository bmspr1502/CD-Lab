%option noyywrap
%{
	#include<stdio.h>
%}

%%
[a-z]+ {
	printf("\nLowercase letter = "); ECHO;
	printf("\nStart of 1st yymore\n");
	yymore();
	printf("\nEnd of 1st yymore\n");
}
[A-Z]+ {
	printf("\nUppercase letter = "); ECHO;
	printf("\nStart of 2nd yymore\n");
	yymore();
	printf("\nEnd of 2nd yymore\n");
}
%%

int main()
{
	yylex();
	return 0;
}