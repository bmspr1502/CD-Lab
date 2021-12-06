%{
    #include<stdio.h>
    #include<ctype.h>
    int flag=0;
    int yylex();
    void yyerror();
%}

%token NUMBER
%left '&' '|'
%right '!'

%%
S:E'\n' {printf("\nThe Result is %d\n",$$); return 0;};
E:E'&'E {$$=$1&$3;}
|E'|'E {$$=$1|$3;}
|'!'E {$$=!$2;}
| NUMBER {$$=$1;}
;
%%

void main()
{
    printf("\nEnter the logical operators and the operands\n");
    yyparse();
    if(flag==0)
        printf("\nEntered logical expression is Valid\n");
}

void yyerror()
{
    printf("\nEntered logical expression is Invalid\n\n");
    flag=1;
}
