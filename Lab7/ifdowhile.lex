%option noyywrap

%{
	#include<string.h>
    int n = 0, i, j, m;
    char stack[10][1024];
%}

%%

if\(.+\)   {
    printf("while(");
    j = 0;
    for(i = 3; i < yyleng-1; i++) {
        printf("%c", yytext[i]);

        if(yytext[i] == '=' && yytext[i+1] == '=') {
            stack[n][j++] = '!';
        }
        else {
            stack[n][j++] = yytext[i];
        }
    }
    printf(") {");
    n++;
}

.*; {
    for(i=0; i < yyleng && yytext[i] == ' '; i++);
    m = i / 4;
    
    printf("%s\n", yytext);
    for(i=0; i<m; i++) {
        printf("    ");
    }
    printf("break;\n");
    for(i = 0; i < m-1; i++) {
        printf("    ");
    }
    printf("}");
    n--;
}

.*else {
    for(i=0; i < yyleng && yytext[i] == ' '; i++);
    m = i / 4;
    for(i = m; i < n; i++) {
        for(j = 0; j < n - i; j++) {
            printf("    ");
        }
        printf("break;\n");
        for(j = 1; j < n - i; j++) {
            printf("    ");
        }
        printf("}\n");
    }
    n = m;

    for(i=0; i<m; i++) {
        printf("    ");
    }
    printf("while(%s) {", stack[n]);
    n++;
}

%%

int main() {
    FILE *fd = fopen("inp3.txt", "r");
    yyin = fd;
    yylex();

    printf("\n");
    for(i = 0; i < n; i++) {
        for(j = 0; j < n - i; j++) {
            printf("    ");
        }
        printf("break;\n");
        for(j = 1; j < n - i; j++) {
            printf("    ");
        }
        printf("}\n");
    }
    return 0;
}