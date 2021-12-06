%{
    #include<stdio.h>
    #include<ctype.h> 
    int yylex();
    int yyerror();
%}
%token DIGIT 
%left '+''-' 
%left '*''/'
%%
line : expression '\n' {printf("answer = %d\n\n",(int)$$); return 0;} 
;
expression : '+' expression expression {$$ = $2 + $3;} 
    | '-' expression expression {$$ = $2 - $3;}
    | '*' expression expression {$$ = $2 * $3;} 
    | '/' expression expression {$$ = $2 / $3;} 
    | '(' expression ')' {$$ = $2;}
    | DIGIT {$$ = $1;}
; 
%%
#include "lex.yy.c"
int main() 
{ 
    yyparse();
}
int yyerror() 
{
    printf("Invalid expression!\n\n"); 
    exit(1);
}

