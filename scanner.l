%{
    #include <iostream>

    extern "C" int yylex();
    // extern int yylex();
%}

%option noyywrap


DIGIT               [0-9]
IDENTIFIER          [a-zA-Z][a-zA-Z0-9]*
COMMENT             #.*\n
ASSIGN_OP           ":="
ADD_OP              "+"
SUB_OP              "-"
MUL_OP              "*"
DIV_OP              "/"
EQ_OP               "="
NEQ_OP              "!="
LT_OP               "<"
LTE_OP              "<="
GT_OP               ">"
GTE_OP              ">="
OPEN_PAR            "("
CLOSED_PAR          ")"
SEMICOLON           ";"
COMMA               ","

%%

PROGRAM							{ std::cout << "Token Type: KEYWORD\nValue: " << yytext << "\n"; }
BEGIN							{ std::cout << "Token Type: KEYWORD\nValue: " << yytext << "\n"; }
END								{ std::cout << "Token Type: KEYWORD\nValue: " << yytext << "\n"; }
FUNCTION						{ std::cout << "Token Type: KEYWORD\nValue: " << yytext << "\n"; }
READ							{ std::cout << "Token Type: KEYWORD\nValue: " << yytext << "\n"; }
WRITE							{ std::cout << "Token Type: KEYWORD\nValue: " << yytext << "\n"; }
IF								{ std::cout << "Token Type: KEYWORD\nValue: " << yytext << "\n"; }
ELSE							{ std::cout << "Token Type: KEYWORD\nValue: " << yytext << "\n"; }
FI							    { std::cout << "Token Type: KEYWORD\nValue: " << yytext << "\n"; }
FOR							    { std::cout << "Token Type: KEYWORD\nValue: " << yytext << "\n"; }
ROF						        { std::cout << "Token Type: KEYWORD\nValue: " << yytext << "\n"; }
RETURN							{ std::cout << "Token Type: KEYWORD\nValue: " << yytext << "\n"; }
INT								{ std::cout << "Token Type: KEYWORD\nValue: " << yytext << "\n"; }
VOID							{ std::cout << "Token Type: KEYWORD\nValue: " << yytext << "\n"; }
STRING							{ std::cout << "Token Type: KEYWORD\nValue: " << yytext << "\n"; }
FLOAT							{ std::cout << "Token Type: KEYWORD\nValue: " << yytext << "\n"; }

{COMMENT}                       {}

{ASSIGN_OP}                     { std::cout << "Token Type: OPERATOR\nValue: " << yytext << "\n"; }
{ADD_OP}                        { std::cout << "Token Type: OPERATOR\nValue: " << yytext << "\n"; }
{SUB_OP}                        { std::cout << "Token Type: OPERATOR\nValue: " << yytext << "\n"; }
{MUL_OP}                        { std::cout << "Token Type: OPERATOR\nValue: " << yytext << "\n"; }
{DIV_OP}                        { std::cout << "Token Type: OPERATOR\nValue: " << yytext << "\n"; }
{EQ_OP}                         { std::cout << "Token Type: OPERATOR\nValue: " << yytext << "\n"; }
{NEQ_OP}                        { std::cout << "Token Type: OPERATOR\nValue: " << yytext << "\n"; }
{LT_OP}                         { std::cout << "Token Type: OPERATOR\nValue: " << yytext << "\n"; }
{LTE_OP}                        { std::cout << "Token Type: OPERATOR\nValue: " << yytext << "\n"; }
{GT_OP}                         { std::cout << "Token Type: OPERATOR\nValue: " << yytext << "\n"; }
{GTE_OP}                        { std::cout << "Token Type: OPERATOR\nValue: " << yytext << "\n"; }
{OPEN_PAR}                      { std::cout << "Token Type: OPERATOR\nValue: " << yytext << "\n"; }
{CLOSED_PAR}                    { std::cout << "Token Type: OPERATOR\nValue: " << yytext << "\n"; }
{SEMICOLON}                     { std::cout << "Token Type: OPERATOR\nValue: " << yytext << "\n"; }
{COMMA}                         { std::cout << "Token Type: OPERATOR\nValue: " << yytext << "\n"; }


{DIGIT}+                        { std::cout << "Token Type: INTLITERAL\nValue: " << yytext << "\n"; }

\"[^"]*\"                       { std::cout << "Token Type: STRINGLITERAL\nValue: " << yytext << "\n"; }

{IDENTIFIER}                    { std::cout << "Token Type: IDENTIFIER\nValue: " << yytext << "\n"; }

{DIGIT}*\.{DIGIT}+              { std::cout << "Token Type: FLOATLITERAL\nValue: " << yytext << "\n"; }

[ \t\n]                         {}

%%

int main(int argc, char** argv) {
    while(yylex());
    return 0;
}
