%{
    #include<stdio.h>
    void yyerror(char*);
    int yylex();
%}

%token FOR ID BINARYOP UNARYOP NUMBER

%%
program: FOR '(' lexpression ';' lexpression ';' lexpression ')' lbody {printf("Result: for-Loop syntax is correct\n\nEnter forExpression:\n");}
;
lbody: statement
| codeblock
;
codeblock:'{' statement_list '}'
;
statement_list: statement_list statement
|
;
statement: lexpression ';'
;
lexpression: fexpression
|
;
fexpression: fexpression ',' expression
|expression
|'(' fexpression ')'
;
expression: ID BINARYOP expression
| ID UNARYOP
| UNARYOP ID
| ID
| NUMBER
;
%%

void main()
{
    printf("\nEnter for-Expression:\n");
    yyparse();
}
void yyerror(char *s)
{
    printf("Result: Incorrect Syntax\n\n");
}