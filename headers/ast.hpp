#ifndef AST_HPP
#define AST_HPP

#include <bits/stdc++.h>

class ASTNode{
    public:
        static std::string id_type;
        std::string type;
        ASTNode *left;
        ASTNode *right;
};