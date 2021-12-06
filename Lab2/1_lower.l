%option noyywrap
%{
	#include<stdio.h>
	int check=0,c=0;
%}

%%
[a-z] {check++;}
[^a-z] {c++;}
%%
int main()
{
	yylex();

	if(!check && c>0)
		printf("The given string is a match, does not contain lower case letters");

	else
		printf("The given string does not match");

	return 0;
}