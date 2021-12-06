%{
    #include<stdio.h>
    #include<string.h>
    int err_no=0,fl=0,i=0,j=0,type[100];
    char symbol[100][100],temp[100];
%}

%token IDENTIFIER NEWLINE SE COMMA INTEGER FLOAT CHARACTER DOUBLE

%%
START:S1 NEWLINE {return ;}
;
S1:S NEWLINE S1
|
S NEWLINE
;
S: INTEGER L1 E
|
FLOAT L2 E
|
CHARACTER L3 E
|
DOUBLE L4 E
|
INTEGER L1 E S
|
FLOAT L2 E S
| 
CHARACTER L3 E S
| 
DOUBLE L4 E S
|
L1:L1 COMMA IDENTIFIER {
    strcpy(temp,(char *)$3); 
    insert(0);
    }
|IDENTIFIER {
    strcpy(temp,(char *)$1); 
    insert(0);
    }
;
L2:L2 COMMA IDENTIFIER {
    strcpy(temp,(char *)$3); 
    insert(1);
    }
|IDENTIFIER {
    strcpy(temp,(char *)$1); 
    insert(1);
    }
;
L3:L3 COMMA IDENTIFIER {
    strcpy(temp,(char *)$3); 
    insert(2);
    }
|IDENTIFIER {
    strcpy(temp,(char *)$1); 
    insert(2);
    }
;
L4:L4 COMMA IDENTIFIER {
    strcpy(temp,(char *)$3); 
    insert(3);
    }
|IDENTIFIER {
    strcpy(temp,(char *)$1); 
    insert(3);
    }
;
E:SE
;
%%

void yyerror(const char *str){
    printf("error");
}

int yywrap(){
    return 1;
}

int main() {
    yyparse();
    printf("TYPE SYMBOL\n");
    if(err_no==0) {
        for(j=0;j<i;j++) {
            if(type[j]==0) printf("INTEGER ");
            if(type[j]==1) printf("FLOAT ");
            if(type[j]==2) printf("CHARACTER ");
            if(type[j]==3) printf("DOUBLE ");
            printf("%s\n",symbol[j]);
        }
    }
}

void insert(int type1) {
    fl=0;

    for(j=0;j<i;j++)
        if(strcmp(temp,symbol[j])==0) {
            if(type[i]==type1)
                printf("Redeclaration of variable");
            else {
                printf("Multiple Declaration of Variable");
                err_no=1;
            }
            fl=1;
        }

    if(fl==0) {
        type[i]=type1;
        strcpy(symbol[i],temp);
        i++;
    }
}


