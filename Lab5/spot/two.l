%option noyywrap

%{
    #include <stdio.h>
%}

%%
[^a-z]+[ \t\n] {
    fprintf(yyout, "%s (match)\n", yytext);
}
.* {fprintf(yyout, "%s (not match)\n", yytext);}
%%


int main(int argc, char *argv[]){
    extern FILE *yyin, *yyout;
    yyin = fopen(argv[1], "r");
    yyout = fopen(argv[2], "w");

    yylex();
    return 0;
}