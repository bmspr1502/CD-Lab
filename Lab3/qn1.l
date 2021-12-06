%option noyywrap
%{
	#include <stdio.h>
%}

keyword if|else|while|int|switch|for|char|return|goto 
%%
"+"|"-"|"*"|"/"|"%"|"++"|"--" {
	printf("%s = Arithmetic operator\n", yytext);
}

"=="|"!="|"<"|">"|"<="|">="  { 
	printf("%s = Relational operators\n", yytext);
}

"&&"|"||"|"!" {
	printf("%s = Logical operator\n",yytext);
}

"&"|"|"|"^"|"~"|"<<"|">>" {
	printf("%s = Bit-wise operator\n",yytext);
}

"="|"+="|"-="|"*="|"/="|"%="|"<<="|">>="|"&="|"^="|"|=" {
	printf("%s = Assignment operators\n", yytext);
}

"#"|"@"|"$"|"_"|"{"|"}"|"["|"]"|"("|")"|":"|";"|"."|"," {
	printf("%s = Special character\n", yytext);
}

{keyword}[ \t]*$ {
	printf("%s = Keyword\n", yytext);
}

([a-zA-Z_]([a-zA-Z0-9_])*) {
	printf("%s = Identifier\n", yytext);
}

([0-9]+) {
	printf("%s = Number\n", yytext); 
}

[ \n\t]+;
.+;
%%
int main() {
	yylex();
	return 0;
}