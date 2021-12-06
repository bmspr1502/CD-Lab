%option noyywrap
%{
	#include<stdio.h>
%}

%%
^(abb)$ {
	printf("%s accepted under rule abb\n", yytext);}
^(a*b+)$ {
	printf("%s accepted under rule a*b+\n", yytext);}
^(a*)[ \n\t]$ {
	printf("%s accepted under rule a*\n", yytext);}
[a-zA-Z0-9]+ {
	printf("%s is not accepted\n", yytext);
}
[\n\t] 
.*
%%
int main()
{
	yylex();
	return 0;
}