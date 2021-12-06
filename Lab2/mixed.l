%option noyywrap
%{
	#include<stdio.h>
	#include<string.h>
	#define SIZE 256
	char msg[SIZE][SIZE];
	int count=0;
%}

lower [a-z]
upper [A-Z]
alpha[a-zA-Z]
%%
({lower}{alpha}*{upper}{alpha}*)|({upper}{alpha}*{lower}{alpha}*) {
	strcpy(msg[count],yytext);
	printf("%s",yytext);
	count++;
}

%%
int main()
{
	yylex();
	printf("There were %d number of mixed case words. They are: \n", count);
	int i=0; 
	for(i=0; i<count; i++){
		printf("%d. %s\n",i+1, msg[i]);
		}
	return 0;
}