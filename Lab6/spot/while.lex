%option noyywrap
%{
	#include <string.h>
	int init = 1, cond = 0, step = 0;
	char init_buffer[20], cond_buffer[20], step_buffer[20], content_buffer[100];
%}
%%
"while(".+")" {
    printf("HOOOOO");
    int i=0;
    for(i=0; i<yyleng-7; i++){
        cond_buffer[i] = yytext[i+7];
    }
    cond_buffer[i]='\0';
	init = 0;
	cond = 1;
}
"{" {
	cond = 0;
	step = 1;
}
[\n]"}"$ {
    if(step){
        int i;
        for(i=1; i<yyleng-2; i++)
            step_buffer[i-1] = yytext[i];
        step_buffer[i]='\0';
        printf("%s)\n", step_buffer);
    }
}
; {}
.+ {
	if(init) {
		//strcat(init_buffer, yytext);
        printf("for(%s;", yytext);
        init = 0;
    }
	else if(cond){
		//strcat(cond_buffer, yytext);
        printf("%s;",cond_buffer);
        cond = 0;
    }
	else{
        //strcat(content_buffer, yytext);
        printf("%s",yytext);
    }
}
%%
int main(int argc, char* argv[]) {	
	if(argc > 1) {
		FILE* fp = fopen(argv[1], "r");
		if(fp) 
			yyin = fp;	
	}
	yylex();
	return 0;
}