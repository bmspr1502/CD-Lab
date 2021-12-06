%option noyywrap
%{
    // 2019103555
    // 1. b. Convert the given nested if consisting of multiple expressions into a single if  
    #include <stdio.h>
    int i, n = 0, j;
%}

%%

\{ {
    n++;
}

\}  {
    n--;
}

if\(.+\)    {
    if(n == 0 || n==1) {
        for(i = 0; i < yyleng-1; i++) {
            printf("%c", yytext[i]);
        }
    }
    else {
        printf(" && ");
        for(i = 3; i < yyleng-1; i++) {
            printf("%c", yytext[i]);
        }
    }
}

.*; {
    printf(")\n");
    i = 0;
    while(yytext[i] == ' ' && i < yyleng) {
        i++;
    }
    
    printf("    ");

    while(i < yyleng) {
        printf("%c", yytext[i]);
        i++;
    }
    printf("\n");
}

.|\n

%%

int main() {
    FILE* fd = fopen("1b.txt", "r");
    yyin = fd;
    yylex();
    return 0;
}