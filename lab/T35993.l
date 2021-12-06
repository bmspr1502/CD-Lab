/* 2019103599 */
%option noyywrap
%{
	#include<string.h>
	int i,op=0,count=-1;
	char cond[5][100], body[5][100];
%}
ws [ \t]
wsn [ \t\n]
%x IFCOND IFBODY
%x REM
%%
if{ws}* { BEGIN(IFCOND); }
<IFCOND>\n { if (yyleng > 1) { count++;	yyless(yyleng - 1); strcpy(cond[count], yytext); }
		else { switch(op) {
			case 0:
				BEGIN(IFBODY); break; 
			case 1:
				fprintf(yyout, "if (%s && %s)\n", cond[0], cond[1]);
				BEGIN(REM); break;
			case 2:
				fprintf(yyout, "if (%s || %s)\n", cond[0], cond[1]);
				BEGIN(REM); break; } } }
<IFBODY>if{wsn}*		{ op = 1; BEGIN(IFCOND); }
<IFBODY>else{wsn}*if{wsn}*	{ op = 2; BEGIN(IFCOND); }
<IFBODY>.			{ strcat(body[count], yytext); }
<IFCOND>.			yymore();
<REM>.				ECHO;
<*>.				;
%%
int main()
{
		for(i = 0; i < 5; ++i) { body[i][0] = '\0'; }
		extern FILE *yyin, *yyout;
		yyin = fopen("input2.txt", "r");
		yyout = fopen("output3.txt", "w");
		yylex();
		return 0;
}
