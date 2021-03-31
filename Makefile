compiler: lex.yy.c parser.c main.cpp headers/ast.cpp headers/*.hpp
	@g++ -std=c++11 -w -g lex.yy.c parser.c main.cpp headers/ast.cpp -o compiler
	@chmod +x runme.sh
parser.c: parser.y
	@bison -d $^ -o parser.c
lex.yy.c: scanner.l
	@flex $^
clean:
	@rm -f lex.yy.c parser.c parser.h compiler tiny
dev: 
	@echo 'Abhishek Raj'
	@echo '180010002@iitdh.ac.in'
tag:
	git tag -a -f pa5submission -m "submission for PA5"
push:
	git push --tags -f
tiny:
	g++ tinyNew.C -o tiny