%option noyywrap
%{
	#include<stdio.h>
	#include<string.h>
	char macro[100];
	char result[100] = "#define ";
	int i,n=0;
%}

dataTypes int|float|double|char|void
identifiers [a-zA-Z_]([a-zA-Z0-9_]*)
white [ \t]
%%
{dataTypes}{white}
{identifiers}{white}?[\(,\)] {
	for(i=0;i<yyleng;i++) {
		macro[n++] = yytext[i];
	}
}
return.*; {
	strcat(macro, " (");
	n += 2;
	for(i=7;i<yyleng-1;i++) {
		macro[n++] = yytext[i];
	}
	strcat(macro, ")");
}
.|\n
%%

int main(int argc, char *argv[])
{
	FILE *fd = fopen(argv[1],"r");
	yyin = fd;
	yylex();
	strcat(result,macro);
	printf("%s\n", result);
	return 0;
}