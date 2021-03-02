/*
    Acknowledgement(s): (Akshat Karani)
*/

#ifndef SYMBOL_TABLE_HPP
#define SYMBOL_TABLE_HPP

#include <bits/stdc++.h>
#include "entry.hpp"

class SymbolTable
{
public:
    std::string scope;
    
    // Map of name and Entry
    std::unordered_map<std::string, Entry *> symbols;
    std::vector<Entry *> ordered_symbols;

    SymbolTable(std::string scope)
    {
        this->scope = scope;
    }


    void addEntry(std::string name, std::string type)
    {
        Entry* variable = new Entry(name, type);
        ordered_symbols.push_back(variable);
        symbols[name] = variable;
    }

    void addEntry(std::string name, std::string type, std::string value)
    {
        Entry* variable = new Entry(name, type, value);
        ordered_symbols.push_back(variable);
        symbols[name] = variable;
    }

    bool ifExists(std::string name)
    {
        if (symbols.find(name) == symbols.end())
            return false;
        else
            return true;
    }

    void printTable()
    {
        std::cout << "Symbol table " << scope << std::endl;

        for (auto it = ordered_symbols.begin(); it != ordered_symbols.end(); ++it)
        {
            std::cout << "name " << (*it)->name << " type " << (*it)->type;    
            if ((*it)->value != "")
                std::cout << " value " << (*it)->value;
            std::cout << std::endl;
        }
    }
};

#endif
