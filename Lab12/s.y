%{
    #include<stdio.h>
    int flag=0; 
    void yerror();
    int yylex();
%}

%token NUMBER
%left '+' '-'
%left '*' '/' '%'
%left '(' ')'

%%
ArithmeticExpression: E{
    printf("\nAnswer = %d\n",$$);
    return 0;
};
E:E'+'E {$$=$1+$3;}
|E'-'E {$$=$1-$3;}
|E'*'E {$$=$1*$3;}
|E'/'E {$$=$1/$3;}
|E'%'E {$$=$1%$3;}
|'('E')' {$$=$2;}
| NUMBER {$$=$1;}
;
%%

void main(){
    printf("\nEnter the expression:\n");
    yyparse();
    if(flag==0)
    printf("\nValid arithmetic expression\n");
}

void yyerror(){
    printf("\nInvalid arithmetic expression\n");
    flag=1;
}