%{
    #include<stdio.h>
    #include<stdlib.h>
    int yylex(void);
    int yyerror(const char *s);
    extern int yylex();
%}

%token ID NUM OR AND NOT DOUBLE_EQUALS IF SEMI OPEN CLOSE
%left OR AND
%left NOT

%% 
SINGLE_IF_STAT :
IF BOOL_EXPRESSION BOOL_EXPRESSION SEMI {
    printf("THIS IS A VALID IF STATEMENT");
    }
;
BOOL_EXPRESSION :
OPEN BOOL_EXPRESSION CLOSE {
    printf("THIS IS A VALID BOOLEAN EXPRESSION !\n");
    }
| ID AND BOOL_EXPRESSION {;}
| ID OR BOOL_EXPRESSION {;}
| ID DOUBLE_EQUALS NUM {;}
| ID DOUBLE_EQUALS BOOL_EXPRESSION {;}
| NOT BOOL_EXPRESSION {;}
| ID {;}
;
%%

int yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}

int main() {
    yyparse();
    return 0;
}

