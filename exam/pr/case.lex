%option noyywrap
%{
	#include<stdio.h>
%}

%%
[A-Z \t]+ {
    printf("Contains only Upper Case letters.\n");
}
[a-z \t]+ {
    printf("Contains only Lower Case letters.\n");
}
[A-Za-z \t]+ {
    printf("Contains Mixed Case letters.\n");
}
%%

int main(){
    yylex();
    return 0;
}