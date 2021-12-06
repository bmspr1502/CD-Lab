%{
    #include <stdio.h>
    int flag=0;    
%}

%token NUMBER
%left '+' '-'
%left '*' '/' '%'
%left '(' ')'

%%
ArithmeticExpression: E{
    printf("\nResult: %d\n", $$);
    return 0;
}
E:E'+'E {$$=$1+$3;}
|E'-'E {$$=$1-$3;}
|E'*'E {$$=$1*$3;}
|E'/'E {$$=$1/$3;}
|E'%'E {$$=$1%$3;}
|'('E')' {$$=$2;}
| NUMBER {$$=$1;}
;
%%

void main()
{
    printf("\nEnter the Arithmetic operators for Addition,Subtraction, Multiplication, Division and the operands \n");
    yyparse();
    if(flag==0)
    printf("\nEntered arithmetic expression is Valid\n");
}
void yyerror()
{
    printf("\nEntered arithmetic expression is Invalid\n\n");
    flag=1;
}
