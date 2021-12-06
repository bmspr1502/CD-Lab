%option noyywrap
%{
	#include<stdio.h>
	int top = 0;
	char stack[200];
	int precedence(char c) {
		if(c == '^')
			return 3;
		else if(c == '/' || c == '*')
			return 2;
		else if(c == '+' || c == '-')
			return 1;
		else
			return -1;
	}
%}
%%
[a-z] {printf("%c", yytext[0]);}
\^|\+|-|\*|\/ {
	while(top > 0 && precedence(yytext[0]) <= precedence(stack[top-1])) {
		printf("%c", stack[top-1]);
		top--;
	}
	stack[top++] = yytext[0];
}
\( {stack[top++] = yytext[0]; }
\) { 
    while(top > 0 && stack[top-1] != '(') {
        printf("%c", stack[top-1]);
        top--;
    }
}
\n { 
    while(top > 0) {
        if(stack[top-1] == '(') {
            top--;
            continue;
        }
        printf("%c", stack[top-1]);
        top--;
    }
    top = 0;
    printf("\n\n");
}
%%
int main()
{
	yylex();
	return 0;
}