%option noyywrap
%{
	#include<stdio.h>
	int count=0;
%}

%%
[a-zA-Z]*(ab)[a-zA-Z]* {
	count++;
	printf("string: %s\n", yytext);
	}
[ \t\n]+
.+
%%
int main()
{
	yylex();
	if(count)
		printf("%d Matches found, with 1 or more occurence of ab \n", count);
	else
		printf("No Match found.\n");
	return 0;
}