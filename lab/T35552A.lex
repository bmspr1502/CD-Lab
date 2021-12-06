%option noyywrap
%{
    //20191035555
    //Perform the following using LEX/YACC
    //2.a.Identify the tokens and print them

    /*
    Input:-
    for (i = 0; i< (array_size -1); ++i)
    {
        for (j = 0; j <array_size -1 -i; ++j )
        {
            if (i> j){
                sum=sum+a[i][j];
                }
        }
    }
    */
	#include<stdio.h>
	int c = 0,q=0;
%}

%%
if|then|else|for|while|int|float|real|return|def|print {
	printf("%s : Keyword\n", yytext);
}
[a-zA-Z][a-zA-Z0-9]* {
	printf("%s : Identifier\n", yytext);
	c++;
}
[0-9]* {
	printf("%s : Number\n", yytext);
}
[ \t\n] {
	q++;
}
"++" {
	if(c > 1) printf("%s : Post-increment Arithmetic operator\n", yytext);
	else printf("%s : Pre-increment Arithmetic operator\n", yytext);
	c = 0;
}
"+"|"-"|"*"|"/"|"%" {
	printf("%s : Arithmetic operator\n", yytext);
}
"=="|"!="|"<"|">"|"<="|">="  { 
	printf("%s : Relational operator\n", yytext);
}
"&&"|"||"|"!" {
	printf("%s : Logical operator\n", yytext);
}
"&"|"|"|"^"|"~"|"<<"|">>" {
	printf("%s : Bit-wise operator\n", yytext);
}
"="|"+="|"-="|"*="|"/="|"%="|"<<="|">>="|"&="|"^="|"|=" {
	printf("%s : Assignment operator\n", yytext);
}
"!"|"@"|"#"|"$"|"%"|"^"|"&"|"*"|"""|""" {
	printf("%s : Special Character\n", yytext);
}
":" {
    printf("%s : Colon\n", yytext);
}
";" {
    printf("%s : Semicolon\n", yytext);
}
"," {
    printf("%s : Comma\n", yytext);
}
"("|")" {
    printf("%s : Parentheses\n", yytext);
}
"["|"]" {
    printf("%s : Square bracket\n", yytext);
}
"{"|"}" {
    printf("%s : Curly brace\n", yytext);
}
%%
int main()
{
	FILE *fp;
	fp = fopen("2a.txt", "r");
	yyin = fp;
	yylex();
    printf("\nAnd there are %d whitespaces.\n\n",q);
	return 0;
}