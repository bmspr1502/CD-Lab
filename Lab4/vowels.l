%option noyywrap
%{
	#include<stdio.h>
	int vow=0,cons=0;
%}

%%
[aeiouAEIOU] {vow++;}
[a-zA-Z] {cons++;}
[\n] {
	printf("The count of vowels = %d, consonants = %d in the given line.\n", vow, cons);
	vow=0;
	cons=0;
	}
%%
int main()
{
	yylex();
	return 0;
}