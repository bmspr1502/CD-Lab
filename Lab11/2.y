%{
    #include <stdio.h>
    #include <stdlib.h>
    int yylex();
    int yyerror();
%}

%token IDENTIFIER NUMBER FOR LESSEQUAL GREATEREQUAL EQUAL NOTEQUAL OR AND DTYPE PRINTF
%right '=' 
%left OR AND
%left '>' '<' LESSEQUAL GREATEREQUAL EQUAL NOTEQUAL DTYPE PRINTF
%left '+' '-' 
%left '*' '/'
%right UMINUS
%right '!' 
%%
S : ST {
    printf("For construct is valid\n"); 
    return 0;
}
ST : FOR '('DTYPE E ';' E2 ';' E ')' DEF
;
DEF : '{' BODY '}'
| E';' 
| ;
BODY : BODY BODY
| E1 ';'
| BODY ST BODY
|
;
E : IDENTIFIER '=' E
| E '+' E
| E '-' E
| E '*' E
| E '/' E
| E '+' '+' 
| E '-' '-' 
| IDENTIFIER
| NUMBER
;
E1 : IDENTIFIER '=' E3
| PRINTF
;
E3 : E3 '+' E3
| E3 '-' E3
| E3 '*' E3
| E3 '/' E3
| E3 '+' '+'
| E3 '-' '-' 
| E3 LESSEQUAL E3
| E3 GREATEREQUAL E3
| E3 EQUAL E3
| E3 NOTEQUAL E3
| E3 OR E3
| E3 AND E3
| IDENTIFIER
| NUMBER
;
E2 : E'<'E
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