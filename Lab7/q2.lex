%option noyywrap
%{
    #include<string.h>
    char stack[10][1024],buffer[1024];
    int pos=-1,lock=0,curly=0,i=0,j=0;
%}
%%
"if" {
fprintf(yyout,"while");
}
\(.+\)[ \n\t]*"{"? {
    for(i=1;yytext[i]!=')';i++)
        buffer[i-1]=yytext[i];
    buffer[i-1]='\0';
    //push the condition statement into stack
    pos++;
    strcpy(stack[pos],buffer);
    if(yytext[yyleng-1] != '{') {
        fprintf(yyout,"(%s){",buffer);
    }
    else
        fprintf(yyout,"%s",yytext);

    for(i=0;i<1024;i++)
        buffer[i]='\0';
}

"else"[ \n\t]*"{"? {
    fprintf(yyout,"while");
    fprintf(yyout,"(!%s)",stack[pos]);
    fprintf(yyout,"{\n\t");
    if(yytext[yyleng-1] != '{')
        curly=1;
    pos--;
}

"statement "[0-9]";" {
    fprintf(yyout,"%s",yytext);
    if(!lock) {
        fprintf(yyout,"\n\tbreak;");
        fprintf(yyout,"\n}");
        lock=1;
    }
    else {
        fprintf(yyout,"\n\t\tbreak;");
        fprintf(yyout,"\n\t}");
    }
    if(curly&&pos==-1)
        fprintf(yyout,"}");
}
. {
    j=0;
}
%%
int main() {
    extern FILE *yyin,*yyout;
    yyin = fopen("inp.txt","r");
    yylex();
    return 0;
}
