%option noyywrap
%{
	#include<stdio.h>
	int c=0;
%}


allchar [a-zA-Z0-9 \n\t!?]
%%
"/*"{allchar}* {
	c++;
	}
{allchar}*"*/"$ {
	c--;
	if(c==0)
		printf("/* */\nThis is a multiline comment.\n");
	}

"//"{allchar}* {
	printf("%s - This is a single line comment.\n", yytext);
	}
[ \n\t]+;
.+$ {
	printf("%s -\n This is not a comment", yytext);
	}
%%

int main()
{
	yylex();
	return 0;
}