%option noyywrap
%{
	#include<stdio.h>
	#include <stdlib.h>
	int count[10] = {0,0,0,0,0,0,0,0,0,0};
%}
num [0-9]
%%
{num} {
	++count[atoi(yytext)];
	printf("%s",yytext);
	}
[\n] {	
	int i;
	int max = 2;
	for(i=0; i<10; i++){
		if(count[i]>max){
			break;
		}else if(count[i]==2){
			max=1;
		}
	}
	if(i==10)
		printf("\nThis is a valid number.\n");
	else
		printf("\nThis is not a valid number.\n");
	
	for(i=0; i<10; i++){
		count[i]=0;
	}
}
.+;
%%

int main()
{
	yylex();
	return 0;
}