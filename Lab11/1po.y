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
    printf("ANSWER = %d\n\n",(int)$$);
    printf("Valid postfix exprn\n");
    return 0;}
;
exprn : exprn exprn '+' {$$ = $1 + $2;}
| exprn exprn '-' {$$ = $1 - $2;}
| exprn exprn '*' {$$ = $1 * $2;}
| exprn exprn '/' {$$ = $1 / $2;}
| '(' exprn ')' {$$ = $2;}
| NUMBER {$$ = $1;}
;
%%

int yyerror(char * str){
    printf("\nInvalid postfix exprn");
    return 1;
}

int main(){
    printf("\nEnter the exprn : ");
    yyparse();
    return(0);
}