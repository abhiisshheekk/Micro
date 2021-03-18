#include <iostream>
#include <string>
#include <vector>
#include "headers/ast.hpp"
#include "headers/codeObject.hpp"
#include "headers/assemblyCode.hpp"
#include "headers/symbolTableStack.hpp"
#include "parser.h"
#include <stdio.h>


extern SymbolTableStack *tableStack;
extern AssemblyCode *assembly_code;
extern CodeObject *threeAC;

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
            // tableStack->printStack();
            fclose(yyin);

            // threeAC->print();
            assembly_code->generateCode(threeAC, tableStack);
            assembly_code->print();
            std::cout << "sys halt" << std::endl;
            // yylex();
        }
    }
    // if(retval == 0)
	    // printf("Accepted\n");
    
    return 0;
}