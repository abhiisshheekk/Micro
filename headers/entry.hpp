/*
    Acknowledgement(s): (Akshat Karani)
*/

#ifndef ENTRY_HPP
#define ENTRY_HPP

#include <bits/stdc++.h>

class Entry
{
public:
    std::string name, type, value;
    std::string stackname;

    Entry(std::string name, std::string type)
    {
        this->name = name;
        this->type = type;
        this->value = "";
    }
    
    Entry(std::string name, std::string type, std::string value)
    {
        this->name = name;
        this->type = type;
        this->value = value;
    }

};

#endif
