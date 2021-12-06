%option noyywrap
%{
	#include<stdio.h>
	#include<string.h>
	int n=0,i;
	char expr[20], value[20];
%}

%%
"switch(".+")" {
	for(i=0;i<yyleng-8;i++)
		expr[i] = yytext[i+7];
	expr[i] = '\0';
}
case.*: {
	for(i=0;i<yyleng-5;i++)
		value[i] = yytext[i+4];
	value[i] = '\0';
	if(n==0){
		printf("if(%s == %s)",expr,value);
		n++;
	}
	else {
		printf("else if(%s == %s)", expr,value);
		n++;
	}
}
break;
default: {printf("else");}
\{|\}
%%
int main()
{
	FILE*fd = fopen("input.txt","r");
	yyin = fd;
	yylex();
	return 0;
}