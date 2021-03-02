#include <stdio.h>
#include <string>
#include <vector>
#include "parser.h"
#include "headers/symbolTableStack.hpp"


extern SymbolTableStack *tableStack;
int yylex();
int yyparse();
void yyerror(char const *err){
    // printf("Not accepted\n");
};

int main(int argc, char* argv[]) {
	extern FILE *yyin;
    int retval;
    if (argc < 2) {
        printf("usage: ./compiler <filename> \n");
    }
    else {
        if (!(yyin = fopen(argv[1], "r"))) {
            printf("Error while opening the file.\n"); 
        }
        else {
            yyin = fopen(argv[1], "r");
            // yyset_in(yyin);
			retval = yyparse();
            tableStack->printStack();
            fclose(yyin);
            // yylex();
        }
    }
    // if(retval == 0)
	    // printf("Accepted\n");
    
    return 0;
}