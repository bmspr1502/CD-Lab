%option noyywrap
%{
    #include <stdio.h>
    int i, n = 0, j;
%}

%%

if\(.+\)    {
    i = 0;
    while(yytext[i] != '&' && i < yyleng) {
        printf("%c", yytext[i]);
        i++;
    }
    printf(")\n");
    n++;

    while(i < yyleng) {
        i=i+2;
        if(i > yyleng) {
            break;
        }
        for(j=0; j < n; j++) {
            printf("\t");
        }
        printf("if(");
        while(yytext[i] != '&' && i < yyleng && yytext[i] != ')') {
            printf("%c", yytext[i]);
            i++;
        }
        n++;
        printf(")\n");
    }
}

.*; {
    for(j=1; j < n; j++) {
            printf("\t");
    }
    printf("%s\n", yytext);
    n=0;
}

.|\n

%%

int main() {
    FILE* fd = fopen("input.txt", "r");
    yyin = fd;
    yylex();
    return 0;
}