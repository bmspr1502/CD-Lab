%option noyywrap

%{
    //2019103555
    /*
    3. Write  a  Lex  program  that  accepts  a  string  from  the  command  line  argument  and  determine 
    whether  it  comprises  of  only  lowercase,  mixed  case  and  only  upper  case  characters.  
    Display  the character, word and line count. Store them into a simple symbol table.
    */
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    int ch=0, w=0, lines=0;
    char symbol[100][100], temp[100];
    int type[100];
    char *typecase[] = {"LOWERCASE", "UPPERCASE", "MIXEDCASE"};
%}

lowercase [a-z]
uppercase [A-Z]
mixedcase [a-zA-Z]

%%
{lowercase}+ {
    ch+=yyleng;
    strcpy(symbol[w], yytext);
    type[w] = 0;
    w++;
}
{uppercase}+ {
    ch+=yyleng;
    strcpy(symbol[w], yytext);
    type[w] = 1;
    w++;
}
{mixedcase}+ {
    ch+=yyleng;
    strcpy(symbol[w], yytext);
    type[w] = 2;
    w++;
}
[ \t]+ {
    ch++;
}
[\n]+ {
    lines++;
}
%%

int main(){
    FILE* fd = fopen("inp.txt", "r");
    yyin = fd;
    yylex();
    printf("All the strings are parsed.\n");
    printf("\nThere are %d characters, forming %d words in %d lines.\n\n", ch, w, lines);

    printf("SYMBOL TABLE\n");
    printf("============\n");

    printf("S.NO\tWORD\t\tTYPE\n");
    for(int x = 0; x<w; x++){
        printf("%d\t%s\t\t%s\n", x+1, symbol[x], typecase[type[x]]);
    }
    
    return 0;
}