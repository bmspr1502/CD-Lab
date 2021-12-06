%option noyywrap
%{
	#include<stdio.h>

%}

evenab (ab|ba)(aa|bb)*(ba|ab)
%%
(aa|bb|(ab|ba)(aa|bb)*(ba|ab))*(b|(ab|ba)(bb|aa)*a)$ {
	printf("%s is accepted\n", yytext);
}
.+ {
	printf("%s is not accepted\n", yytext);
	}
%%
int main()
{
	yylex();
	return 0;
}