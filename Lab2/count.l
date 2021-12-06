%option noyywrap
%{
	#include<stdio.h>
	int a=0,b=0,c=0,d=0,e=0,f=0,g=0;
%}

%%
if|then|else|for|while|int|float|real {
	printf("%s\t: Keyword\n",yytext);
	g++;
}
[a-zA-Z_][a-zA-Z0-9_]* {
	printf("%s\t: Identifier\n",yytext);
	a++;
}
[0-9]* {
	printf("%s\t: Number\n", yytext);
	b++;
}
[\t\n] {
	printf("%s\t: Whitespace\n", yytext);
	c++;
}
:= {
	printf("%s\t: Assignment symbol\n", yytext);
	d++;
}
[+-/*] {
	printf("%s\t: Operator Symbol\n", yytext);
	e++;
}
"!"|"@"|"#"|"$"|"%"|"^"|"&"|"*"|"“"|"”"|"("|")" {
	printf("%s\t: Special Character\n", yytext);
	f++;
}
%%

int main()
{
	yylex();
	printf("\nTotal number of characters: \n");
	printf("\nIdentifiers: %d",a);
	printf("\nNumbers: %d",b);
	printf("\nWhitespace: %d",c);
	printf("\nAssignment symbol: %d",d);
	printf("\nOperator symbols: %d",e);
	printf("\nSpecial characters: %d",f);
	printf("\nKeywords: %d\n",g);
	return 0;
}