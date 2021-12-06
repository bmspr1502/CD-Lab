%{
    #include "y.tab.h"
    #include<stdio.h>
    #include<string.h>
%}

%option noyywrap

%%
("if") {
    printf("if\n"); 
    return IF;
    }
[a-zA-Z][a-zA-Z0-9]* {
    printf("Identifier\n"); 
    return ID;
    }
[0-9]+ {
    printf("Number: \n"); 
    return NUM;
    }
(\|\|) {
    printf("Or\n"); 
    return OR;
    }
("&&") {
    printf("And\n"); 
    return AND;
    }
("!") {
    printf("Not\n"); 
    return NOT;
    }
(\=\=) {
    printf("Double Equals\n"); 
    return DOUBLE_EQUALS;
    }
(;) {
    printf("Semicolon\n"); 
    return SEMI;
    }
\( {
    printf("Open bracket\n"); 
    return OPEN;
    }
\) {
    printf("closing bracket\n"); 
    return CLOSE;
    }
. {;}
[\t\n]+ {;}
%%