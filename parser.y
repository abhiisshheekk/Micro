%{
	/*
    	Acknowledgement(s): (Akshat Karani)
	*/

	#include <stdio.h>
	#include <string>
	#include <vector>
	#include "headers/symbolTableStack.hpp"
	// #include<stdlib.h>

	// int yyparse();

	extern "C" int yylex();
	void yyerror(char const *s);
	SymbolTableStack *tableStack = new SymbolTableStack();
%}



%token _PROGRAM
%token _BEGIN
%token _VOID
%token <stringval> IDENTIFIER
%token _INT
%token _FLOAT
%token FLOATLITERAL
%token INTLITERAL
%token <stringval> STRINGLITERAL
%token _STRING
%token _READ
%token _WRITE
%token _FUNCTION
%token _RETURN
%token _IF
%token _ELSE
%token _FI
%token _FOR
%token _ROF
%token _END
%token ASSIGN_OP
%token ADD_OP
%token SUB_OP
%token MUL_OP
%token DIV_OP
%token EQ_OP
%token NEQ_OP
%token LT_OP
%token LTE_OP
%token GT_OP
%token GTE_OP
%token OPEN_PAR
%token CLOSED_PAR
%token SEMICOLON
%token COMMA

%union {
    int intval;
    float floatval;
    std::string* stringval;
    std::vector<std::string*> *stringlist;
}

%type <intval> var_type
%type <stringval> str id
%type <stringlist> id_list id_tail

%%

program:			_PROGRAM id _BEGIN { tableStack->addNewTable("GLOBAL"); } pgm_body _END { tableStack->removeTable(); }
					;
id:					IDENTIFIER
					;
pgm_body:			decl func_declarations
					;
decl:				string_decl decl | var_decl decl |
					;
string_decl:		_STRING id ASSIGN_OP str SEMICOLON { tableStack->insertSymbol(*($2), "STRING", *($4)); }
					;
str:				STRINGLITERAL
					;
var_decl:			var_type id_list SEMICOLON {
						std::string str_type = "";
						std::vector<std::string*> list = *$2;
						for (int i = list.size(); i != 0; --i) {
							if ($1 == _FLOAT) {
								tableStack->insertSymbol(*(list[i-1]), "FLOAT");
							}
							else if ($1 == _INT) {
								tableStack->insertSymbol(*(list[i-1]), "INT");
							}
						}
					};
var_type:			_FLOAT { $$ = _FLOAT; } | _INT { $$ = _INT; }
					;
any_type:			var_type | _VOID
					;
id_list:			id id_tail {
						$$ = $2;
						$$->push_back($1);
					};
id_tail:			COMMA id id_tail {
						$$ = $3;
						$$->push_back($2);
					} | {
						std::vector<std::string*>* temp = new std::vector<std::string*>;
						$$ = temp;
					};
param_decl_list:	param_decl param_decl_tail |
					;
param_decl:			var_type id {
						if ($1 == _FLOAT)
							tableStack->insertSymbol(*$2, "FLOAT");
						else if ($1 == _INT)
							tableStack->insertSymbol(*$2, "INT");
					};
param_decl_tail:	COMMA param_decl param_decl_tail |
					;
func_declarations:	func_decl func_declarations |
					;
func_decl:			_FUNCTION any_type id { tableStack->addNewTable(*($3)); } OPEN_PAR param_decl_list CLOSED_PAR _BEGIN func_body _END { tableStack->removeTable(); }
					;
func_body:			decl stmt_list 
					;
stmt_list:			stmt stmt_list |
					;
stmt:				base_stmt | if_stmt | for_stmt
					;
base_stmt:			assign_stmt | read_stmt | write_stmt | return_stmt
					;
assign_stmt:		assign_expr SEMICOLON
					;
assign_expr:		id ASSIGN_OP expr
					;
read_stmt:			_READ OPEN_PAR id_list CLOSED_PAR SEMICOLON
					;
write_stmt:			_WRITE OPEN_PAR id_list CLOSED_PAR SEMICOLON
					;
return_stmt:		_RETURN expr SEMICOLON
					;
expr:				expr_prefix factor
					;
expr_prefix:		expr_prefix factor addop |
					;
factor:				factor_prefix postfix_expr
					;
factor_prefix:		factor_prefix postfix_expr mulop |
					;
postfix_expr:		primary | call_expr
					;
call_expr:			id OPEN_PAR expr_list CLOSED_PAR
					;
expr_list:			expr expr_list_tail |
					;
expr_list_tail:		COMMA expr expr_list_tail |
					;
primary:			OPEN_PAR expr CLOSED_PAR | id | INTLITERAL | FLOATLITERAL
					;
addop:				ADD_OP | SUB_OP
					;
mulop:				MUL_OP | DIV_OP
					;
if_stmt:			_IF { tableStack->addNewTable(); } OPEN_PAR cond CLOSED_PAR decl stmt_list { tableStack->removeTable(); } else_part _FI
					;
else_part:			_ELSE { tableStack->addNewTable(); } decl stmt_list { tableStack->removeTable(); } |
					;
cond:				expr compop expr
					;
compop:				LT_OP | GT_OP | EQ_OP | NEQ_OP | LTE_OP | GTE_OP
					;
init_stmt:			assign_expr |
					;
incr_stmt:			assign_expr |
					;
for_stmt:			_FOR { tableStack->addNewTable(); } OPEN_PAR init_stmt SEMICOLON cond SEMICOLON incr_stmt CLOSED_PAR decl stmt_list _ROF { tableStack->removeTable(); }
					;

%%

// #include "lex.yy.c"
