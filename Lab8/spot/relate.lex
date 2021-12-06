%{
    #include<stdio.h>
    #include "y.tab.h"
    extern int yylval;
%}

%%
[0-9]+ {
    yylval=atoi(yytext);
    return NUMBER;
}
"==" {return EQUAL;}
">=" {return GREATEREQUAL;}
"<=" {return LESSEREQUAL;}
"!=" {return NOTEQUAL;}
[\t] ;
[\n] return 0;
. return yytext[0];
%%

int yywrap()
{
    return 1;
}
