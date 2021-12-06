.PHONY: run clean

run: a.out
	./$^

lex.yy.c: tokens.l
	flex $^

parser.tab.c: parser.y
	bison -d $^

a.out: parser.tab.c lex.yy.c 
	gcc -w $^

clean: a.out lex.yy.c parser.tab.*
	rm $^
