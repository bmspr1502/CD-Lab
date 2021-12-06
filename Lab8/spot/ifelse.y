%{
    #include <stdio.h>
    #include <stdlib.h>
    int yylex();
    void yyerror();
%}

%token ID NUM IF ELSE LESSEREQUAL GREATEREQUAL EQUAL NOTEQUAL OR AND LINE
%left OR AND
%left '>' '<' LESSEREQUAL GREATEREQUAL EQUAL NOTEQUAL
%left '!'

%%
S: ST {
 printf("Valid Syntax\n");
 return 0;
}
ST: IF '(' E ')' DEF ELSE DEF;
DEF:
 '{' BODY '}'
 | LINE
 | ST
 |
;
BODY: 
 BODY BODY
 | LINE
 | ST
 |
;
E: 
 | E '<' E
 | E '>' E
 | E LESSEREQUAL E
 | E GREATEREQUAL E
 | E EQUAL E
 | E NOTEQUAL E
 | E OR E
 | E AND E
 | '(' E ')'
 | ID 
 | NUM
;
%%

void main() {
    printf("\nEnter the if else statement:\n");
    yyparse();
} 

void yyerror() {
    printf("\nInvalid syntax\n\n");
}