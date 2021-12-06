%option noyywrap
%{
   #include <stdio.h>

   int openBlocks = 0;
   int openIfs = 0;
   int expectCondition = 0;

   int pendingbrace = 0;
%}

%%
"{" {
    openBlocks++;
    // printf("open: %d\n", openBlocks);
    if(openIfs == 0){
        printf("{\n");
    }

    if(openIfs == 1){
        pendingbrace++;
    }
}

"}" {
    openBlocks--;
    // printf("open: %d\n", openBlocks);
    if(openIfs){
        openIfs--;
        expectCondition = 0;
    }
    
    if(openIfs == 0){
        printf("}\n");
    }
}

"if" {
    openIfs++;

    // if this starts a new one
    if(openIfs == 1){
        printf("\nif(");
    }

    expectCondition = 1;
}

[a-z]+(.*);$ {
    printf(")\n");
    if(pendingbrace){
        for(int i =0; i<pendingbrace; i++){
            printf("{\n");
        }
    }
    pendingbrace = 0;
    printf("%s\n", yytext);
}

\((.*)\)$ {
    if(openIfs > 1){
        printf(" && ");
    }

    for(int i = 1; i < yyleng-1; i++){
        printf("%c", yytext[i]);
    }
}

" "     // consume
[\t]    // consume
[\n]    // consume
%%

void main() {
   yylex();
   printf("\n");
}
