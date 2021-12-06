%option noyywrap
%{
	#include<stdio.h>
	int i, first=1;
%}

alphanum [a-zA-Z0-9]
space [ \t\n]

%%
"if("{alphanum}+" == "{alphanum}+")""{"? {
	if(first){
		fprintf(yyout,"switch(");
		for(i=3; yytext[i]!=' '; i++)
			fprintf(yyout,"%c",yytext[i]);
		fprintf(yyout,")\n{\n");
	}
	first=0;
	fprintf(yyout,"case");
	for(i=3; yytext[i]!=' '; i++);
	i+=3;
	for(; i<yyleng-2; i++)
		fprintf(yyout,"%c",yytext[i]);
	fprintf(yyout,": ");
}

{space}*({alphanum}+";"{space}*)+"}"? {
    fprintf(yyout, "\t");
	for(i=0; i<yyleng-1; i++)
		fprintf(yyout,"%c",yytext[i]);
    fprintf(yyout, "\tbreak;");
}

"else{"?{space}*({alphanum}+";"{space}*)+"}"? {
	fprintf(yyout,"default:");
	for(i=5; i<yyleng-1; i++){
            fprintf(yyout,"%c",yytext[i]);
        }	
        
    fprintf(yyout,"}\n");
}
. ;
%%

int main(int argc, char *argv[])
{
	extern FILE *yyin, *yyout; 
	yyin=fopen(argv[1], "r");
	yyout=fopen(argv[2], "w");
	yylex();
}
