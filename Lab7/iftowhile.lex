%option noyywrap

%{
    #include <stdio.h>
    #include <string.h>
    #include <unistd.h>
    int len = 0;
    int no_while = 1, else_while = 1;
    char buf[1000];
    char expr[1000][1000];
    int expr_len = 0;
%}

%s ifState2 elseState2 
%x startingIf ifExpression ifState1 elseState1

%%
<INITIAL,startingIf>"if"[ ]*"(" {
    printf("do{\n");
    BEGIN(ifExpression);
}

<ifExpression>[a-zA-Z0-9 "||""&&""==""="]+ {
    int i;
    len = 0;
    for (i = 0; i < yyleng; i++)
        buf[len++] = yytext[i];

    buf[len] = '\0';

    printf("goto while%d;\n", no_while);
    char file_while[100];
    sprintf(file_while, "while%d:", no_while);
    strcat(file_while, buf);
    strcat(expr[expr_len++], file_while);

    no_while++;
    BEGIN(ifState1);
}

<ifState1>[\n\t ]*")" {
    printf("do");
    BEGIN(ifState2);
}

<ifState2>"}" {
    --no_while;
    char file_while[100];
    char expression[200];
    expression[0] = '\0';

    int i, j, k = 0;
    sprintf(file_while, "while%d:", no_while);

    for (i = 0; i < expr_len; i++)
    {
        if (strncmp(expr[i], file_while, strlen(file_while)) == 0)
        {
            for (j = strlen(file_while); j < strlen(expr[i]); j++)
            {
                expression[k++] = expr[i][j];
            }

            expression[k] = '\0';
            break;
        }
    }
    printf("goto else_while%d;\n}\n", else_while);
    else_while++;
    printf("while%d:\n}while(%s);\n", no_while, expression);
    BEGIN(elseState1);
}

<ifState2>"if"[ ]*"(" {
    BEGIN(ifExpression);
}

<elseState1>"else"[\n\t ]*"{" {
    printf("do{");
    BEGIN(elseState2);
}
<elseState2>"if"[ ]*"(" {
    BEGIN(ifExpression);
}
<elseState2>"}" {
    else_while--;
    printf("else_while%d:\n }while(0);\n", else_while);
    else_while += 5;
    BEGIN(ifState2);
}
<<EOF>> {
    printf("}while(0);");
    return 0;
}
%%

int main() {
    yyin = fopen("inp.txt", "r");
    yylex();
    return 0;
}