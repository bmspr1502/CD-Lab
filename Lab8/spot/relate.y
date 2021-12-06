%{
#include<stdio.h>
int flag=0;
int yylex();
void yyerror();
%}
%token NUMBER LESSEREQUAL GREATEREQUAL EQUAL NOTEQUAL
%left '>' '<' LESSEREQUAL GREATEREQUAL EQUAL NOTEQUAL
%%
logicalExpression: E{ 
    printf("The Result is %d\n", $$);
    if($$ == 1)
    printf("True\n");
    else
    printf("False\n");
    return 0;
};

E :E'>'E {$$=$1>$3;}
|E'<'E {$$=$1<$3;}
|E GREATEREQUAL E {$$=$1>=$3;}
|E LESSEREQUAL E {$$=$1<=$3;}
|E EQUAL E {$$=$1==$3;}
|E NOTEQUAL E {$$=$1!=$3;}
| NUMBER {$$=$1;}
;
%%

void main()
{
    printf("Enter the Expression with relational operators\n");
    yyparse();
    if(flag==0)
        printf("Entered expression is Valid\n");
}
void yyerror()
{
    printf("Entered expression is Invalid\n");
    flag=1;
}
