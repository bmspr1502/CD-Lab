%{
    #include "y.tab.h"
    int count=0;
%}

%%
"int" {
    count++;
    return INTEGER;
 }
"float" {
    count++;
    return FLOAT;
}
"char" {
    count++; 
    return CHARACTER;
}
"double" {
    count++; 
    return DOUBLE;
}
[a-z]+ {
    yylval=yytext;

    if(count>0)
        return IDENTIFIER;
    return 0;
}
"," return COMMA;
[\n] return NEWLINE;
";" {
    count--;
    return SE;
}
%%