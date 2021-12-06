%option noyywrap
%{
	#include<stdio.h>
	#include<string.h>
	char init[50],cond[50],updt[50],body[100];
	int finit=1,fcond=0,fbody=0,i,k=0;

    void reverse(char *s) {
    int length, c;
    char *begin, *end, temp;
    length = strlen(s);
    begin  = s;
    end    = s;
 
    for (c = 0; c < length - 1; c++)
        end++;
 
    for (c = 0; c < length/2; c++) {        
        temp   = *end;
        *end   = *begin;
        *begin = temp;
 
        begin++;
        end--;
    }
}
%}

%%
"while" {finit=0;}
"(" {fcond=1;}
")" {fcond=0;}
"{" {fbody=1;}
"}" {fbody=0;}
\n ;
. {
	if(finit) strcat(init,yytext);
	if(fcond) strcat(cond,yytext);
	if(fbody) strcat(body,yytext);
}
%%

void main(int argc, char *argv[])
{
	extern FILE *yyin, *yyout; 
	yyin=fopen(argv[1], "r");
	yyout=fopen(argv[2], "w");
	yylex();
	for(i=strlen(body)-2; body[i]!=';'; i--,k++){
		updt[k]=body[i];
		body[i]='\0';
	}
	updt[k]='\0';
    reverse(updt);
	fprintf(yyout,"for(%s%s;%s)\n{\n%s\n}\n",init,cond,updt,body);
}
