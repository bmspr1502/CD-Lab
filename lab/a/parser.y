%{
   #include <stdio.h>
   #include <stdlib.h>
   #include <string.h>

%}


%token IF ID SC EQ NL OB CB OR AND
 
%%
S : STMT {
    printf("parse successfull\n"); 
    return 0;
}

STMT : IF OB EXP CB;
EXP : T OR T | T AND T | T ;
T : ID EQ ID | EXP | OB EXP CB;

%%

int main(){
    yyparse();
    return 0;
}

int yyerror(){
    printf("parse error\n");
}