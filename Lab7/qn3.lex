%option noyywrap
%{
    #include <stdio.h>
    int i, n = 0, j;
%}

%%

if\(.+\)    {
    if(n == 0) {
        for(i = 0; i < yyleng-1; i++) {
            printf("%c", yytext[i]);
        }
        n++;
    }
    else {
        printf(" && ");
        for(i = 3; i < yyleng-1; i++) {
            printf("%c", yytext[i]);
        }
        n++;
    }
}

else.if\(.+\)  {
    n = 1;
    printf("\n");
    for(i = 0; i < yyleng-1; i++) {
        printf("%c", yytext[i]);
    }
}

.*; {
    printf(")\n");
    i = 0;
    while(yytext[i] == ' ' && i < yyleng) {
        i++;
    }
    
    printf("\t");

    while(i < yyleng) {
        printf("%c", yytext[i]);
        i++;
    }
}

.|\n

%%

int main() {
    FILE* fd = fopen("inp5.txt", "r");
    yyin = fd;
    yylex();
    return 0;
}