compiler: lex.yy.c parser.c main.cpp 
	@g++ $^ -o compiler
	@chmod +x runme.sh
parser.c: parser.y
	@bison -d $^ -o parser.c
lex.yy.c: scanner.l
	@flex $^
clean:
	@rm -f lex.yy.c parser.c parser.h compiler
dev: 
	@echo 'Abhishek Raj'
	@echo '180010002@iitdh.ac.in'