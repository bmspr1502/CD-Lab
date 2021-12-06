%option noyywrap
%{
	#include<stdio.h>
    #include <string.h>

%}

%%
[A-Z \t]+ {
    printf("Contains only Upper Case letters.\nReverse: ");
    int i = yyleng;
    for(; i>=0; i--){
        printf("%c", yytext[i]);
    }
    printf("\n");
}
[a-z \t]+ {
    printf("Contains only Lower Case letters.\nReverse: ");
    int i = yyleng;
    for(; i>=0; i--){
        printf("%c", yytext[i]);
    }
    printf("\n");
}
[A-Za-z \t]+ {
    printf("Contains Mixed Case letters.\nReverse: ");
    int i = yyleng;
    for(; i>=0; i--){
        printf("%c", yytext[i]);
    }
    printf("\n");
}
%%

int main(){
    FILE* fd = fopen("inp.txt", "r");
    yyin = fd;
    yylex();
    return 0;
}