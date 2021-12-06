%{
    //2019103555
    /*
        2. b. Validate construct for "for" program
    */
    #include <stdio.h>
    #include <stdlib.h>
    int yylex();
    int yyerror();
%}

%token IDENTIFIER IF NUMBER FOR LESSEQUAL GREATEREQUAL EQUAL NOTEQUAL OR AND DTYPE PRINTF
%right '=' 
%left OR AND
%left '>' '<' LESSEQUAL GREATEREQUAL EQUAL NOTEQUAL DTYPE PRINTF
%left '+' '-' 
%left '*' '/'
%right UMINUS
%right '!' 
%%
S: ST   {   
    printf("\nInput Accepted - Valid Nested For Expression\n\n"); 
    exit(0);
}

ST: FOR '(' E ';' E2 ';' E ')' DEF1;

DEF1: 
    '{' BODY1 '}'
    | FOR '(' E ';' E2 ';' E ')' DEF;
    | IF '(' E2 ')' DEF;
;

BODY1: 
    BODY1 BODY1
    | FOR '(' E ';' E2 ';' E ')' DEF;
;

DEF: 
    '{' BODY '}'
    | E';'
    | FOR '(' E ';' E2 ';' E ')' DEF;
    |
;

BODY: 
    BODY BODY
    | E ';'
    | FOR '(' E ';' E2 ';' E ')' DEF;
    |
;

E: 
    IDENTIFIER '=' E
    | E '+' E
    | E '-' E
    | E '*' E
    | E '/' E
    | E '<' E
    | E '>' E
    | E LESSEQUAL E
    | E GREATEREQUAL E
    | E EQUAL E
    | E NOTEQUAL E
    | E OR E
    | E AND E
    | E '+' '+'
    | E '-' '-'
    | IDENTIFIER 
    | NUMBER
;   

E2: 
    E'<'E
    | E'>'E
    | E LESSEQUAL E
    | E GREATEREQUAL E
    | E EQUAL E
    | E NOTEQUAL E
    | E OR E
    | E AND E
;   

%%

int main(){
    printf("Enter the expression:\n");
    yyparse();
    return 0;
}

int yyerror(){
    printf("For construct is invalid\n");
}