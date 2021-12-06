// 2019103507
%{
    #include <stdio.h>
    #include <stdlib.h>
    extern FILE* yyin;
    int yylex();
    void yyerror();
%}

%token ID NUM FOR LE GE EQ NE OR AND
%right '='
%left OR AND
%left '>' '<' LE GE EQ NE
%left '+' '-'
%left '*' '/'
%right UMINUS
%left '!'

%% 

S: ST   {   
    printf("\nInput Accepted - Valid Nested For Expression\n\n"); 
    exit(0);
}

ST: FOR '(' E ';' E2 ';' E ')' DEF1;

DEF1: 
    '{' BODY1 '}'
    | FOR '(' E ';' E2 ';' E ')' DEF;
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
    ID '=' E
    | E '+' E
    | E '-' E
    | E '*' E
    | E '/' E
    | E '<' E
    | E '>' E
    | E LE E
    | E GE E
    | E EQ E
    | E NE E
    | E OR E
    | E AND E
    | E '+' '+'
    | E '-' '-'
    | ID 
    | NUM
;   

E2: 
    E'<'E
    | E'>'E
    | E LE E
    | E GE E
    | E EQ E
    | E NE E
    | E OR E
    | E AND E
;   

%%

int main() {
    /*
	char file[30];
	printf("\nEnter Filename: ");
	scanf("%s", file);
    */
	yyin = fopen("2a.txt", "r");
    yyparse();
    return 0;
}   

void yyerror() {
    printf("\nInvalid syntax - Invalid nested for expression\n\n");
}