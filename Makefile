compiler: lex.yy.c parser.cpp
	@g++ -std=c++11 main.cpp lex.yy.c parser.cpp headers/Scope.cpp headers/Symbol.cpp headers/ASTNode.cpp headers/Tiny.cpp -o compiler
	@chmod +x runme.sh
parser.cpp: parser.y
	@bison -d -t -o parser.cpp parser.y
lex.yy.c: scanner.l
	@flex $^
clean:
	@rm -f parser.cpp lex.yy.c parser.hpp compiler out 
dev: 
	@echo 'Abhishek Raj'
	@echo '180010002@iitdh.ac.in'
tag:
	git tag -a -f pa6submission -m "submission for PA6"
push:
	git push --tags -f
tiny:
	g++ tinyNew.C -o tiny
tiny4reg:
	g++ tiny4regs.C -o tiny