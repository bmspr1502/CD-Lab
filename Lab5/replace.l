%option noyywrap
%{
	#include<stdio.h>
	#include<string.h>
	char replace_with [] = "Best";
	char replace [] ="A";
%}

%%
[a-zA-Z]+ { 
	if(strcmp(yytext, replace)==0)
		fprintf(yyout, "%s", replace_with);
	else
		fprintf(yyout, "%s", yytext);
}
. fprintf(yyout, "%s", yytext);
%%

//int yywrap() { return 1; }
int main()
{
	extern FILE *yyin, *yyout;
	yyin=fopen("inp1.txt", "r");
	yyout=fopen("out1.txt", "w");
	yylex();
	return 0;
}