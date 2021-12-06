%option noyywrap

%{
    #include <stdio.h>
    #include <string.h>
    char stack[100][100], op1[100], op2[100];
    int top = 0, i;
%}

%%
[a-zA-Z] {
    strcpy(stack[top++], yytext);
}
\^|\+|-|\*|\/ {
    strcpy(op1, stack[--top]);
    strcpy(op2, stack[--top]);

    strcpy(stack[top], "(");
    strcat(stack[top], op2);
    strcat(stack[top], yytext);
    strcat(stack[top], op1);
    strcat(stack[top], ")");
    top++;
}
\n {
    printf("Infix expression : %s\n\n", stack[top-1]);
    top = 0;
    bzero(stack, sizeof(stack));
}
%%

int main() {
    yylex();
    return 0;
}