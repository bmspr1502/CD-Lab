%option noyywrap

%{
    #include <stdio.h>
%}

%%
[A-Z]+ {
	fprintf(yyout,"\nUppercase = %s",yytext);
	yymore();
}
[a-z]+ {
    fprintf(yyout, "\nLower letter = %s",yytext);
    yymore();
}
[ \n]+ {
    fprintf(yyout, "\nWord: %s\n", yytext);
}
%%

int main(int argc, char *argv[]){
    extern FILE *yyin, *yyout;
    yyin = fopen(argv[1], "r");
    yyout = fopen(argv[2], "w");

    yylex();
    return 0;
}