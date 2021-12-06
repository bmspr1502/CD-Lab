%{
    //2019103555
    // 1. a. Validate the given expression and evaluate the Boolean expression using relational and logicaloperators
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
    return ID;
    }
[0-9]+ {
    return NUMBER;
    }
(\|\|) {
    return OR;
    }
("&&") {
    return AND;
    }
("!") {
    return NOT;
    }
(\=\=) {
    return DOUBLE_EQUALS;
    }
(;) {
    return SEMI;
    }
\( {
    return OPEN;
    }
\) {
    return CLOSE;
    }
. {;}
[\t\n]+ {;}
%%