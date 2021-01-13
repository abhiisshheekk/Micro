compiler: lex.yy.c  
	@g++ $< -o compiler
lex.yy.c: scanner.l
	@flex $^
clean:
	@rm lex.yy.c
dev: 
	@echo 'Abhishek Raj'
	@echo '180010002@iitdh.ac.in'