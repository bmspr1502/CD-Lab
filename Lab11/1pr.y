%{
    #include<stdio.h>
    int yylex();
    int yyerror(char *str);
%}

%token NUMBER
%left '+''-'
%left '*''/'
%nonassoc UMINUS

%%
res : exprn {
    printf("Answer for the expression = %d \n",(int)$$);
    printf("Valid prefix expression\n");
    return 0;
}
;
exprn : '+' exprn exprn {$$ = $2 + $3;}
| '-' exprn exprn {$$ = $2 - $3;}
| '*' exprn exprn {$$ = $2 * $3;}
| '/' exprn exprn {$$ = $2 / $3;}
| '(' exprn ')' {$$ = $2;}
| NUMBER {$$ = $1;}
;
%%

int yyerror(char * str){
    printf("\nInvalid prefix expression");
    return 1;
}

int main(){
    printf("\nEnter the expression : ");
    yyparse();
    return(0);
}


