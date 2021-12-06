%option noyywrap
%{
    #include<stdio.h>
    #include "parser.tab.h"
%}


alpha [A-Za-z]
digit [0-9]

%%
if          {return IF;}

";"                                     {return SC;}

"=="                                    {return EQ;}
"("                                     {return OB;}
")"                                     {return CB;}
"||"                                    {return OR;}
"&&"                                    {return AND;}

(_|{alpha})(_|{alpha}|{digit})*         {return ID;}

[\t]            // consume
" "             // consume
[\n]            {return 0;}
.               {return 0;}
%%