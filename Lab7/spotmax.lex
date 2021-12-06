%option noyywrap

%{
	#include<stdio.h>
	#include<string.h>
	char buffStart[200], buffEnd[200], buffFuncName[200], buffFuncArg[200], buffFuncDef[200];
	int i, k=0, start=1, end=0, funcName=0, funcArg=0, funcDef=0;
%}

whitespace [ \t\n]*
%%
"int main()"{whitespace}"{"	{
    strcat(buffEnd,yytext); end=1; funcDef=0;
}

"#define " { 
    start=0; 
    funcName=1; 
}

"(" { 
    if(funcName) {
        funcName=0; 
        funcArg=1;
    } 
	else if(end) 
        strcat(buffEnd,yytext);
}

[\t\n] {
    if(end) 
        strcat(buffEnd,yytext);
}

")"{whitespace} {
    if(funcArg) {
        funcArg=0; 
        funcDef=1;
    }
	else if(end) 
        strcat(buffEnd,yytext);
}
.	{
    if(start) 
        strcat(buffStart,yytext); 
	else if(end) 
        strcat(buffEnd,yytext);
	else if(funcName) 
        strcat(buffFuncName,yytext);
	else if(funcArg) { 
        if(strcmp(yytext," ")==0) 
            continue;
		else if(strcmp(yytext,",")==0) 
            strcat(buffFuncArg,yytext);
		else { 
            strcat(buffFuncArg,"int "); 
            strcat(buffFuncArg,yytext);
        } 
    }
	else if(funcDef && strcmp(yytext,";")!=0) 
        strcat(buffFuncDef,yytext);
}
%%

int main()
{
	extern FILE *yyout;
	yyout = fopen("out.txt","w");
	yylex();
	fprintf(yyout,"%sint %s(%s) {\n\treturn (%s);\n}\n%s",buffStart,buffFuncName,buffFuncArg,buffFuncDef,buffEnd);
	return 0;
}