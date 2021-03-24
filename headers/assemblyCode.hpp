/*
    Acknowledgement(s): (Akshat Karani)
*/

#ifndef ASSEMBLYCODE_HPP
#define ASSEMBLYCODE_HPP

#include <bits/stdc++.h>
#include "codeObject.hpp"
#include "symbolTable.hpp"

class AssemblyCode
{
    std::vector<CodeLine *> assembly;
    int register_no = -1;
    std::unordered_map<std::string, std::string> temp_to_reg;
public:
    
    std::string getRegister(std::string temporary)
    {   
        if (tempExists(temporary))
            return temp_to_reg.find(temporary)->second;
        else
        {
            std::string reg = "r" + std::to_string(++register_no);
            this->temp_to_reg[temporary] = reg;
            return reg;
        }
    }

    std::string getNewRegister()
    {
        return "r" + std::to_string(++register_no);
    }

    bool isTemporary(std::string temp)
    {
        return (temp[0] == '$');
    }

    bool tempExists(std::string temp)
    {
        return (temp_to_reg.find(temp) != temp_to_reg.end());
    }

	std::string toLower(std::string s) {
		for (char& i : s) {
			i |= ' ';
		}
		if (s.back() == 'f') {
			s.back() = 'r';
		}
		return s;
	}

    void generateCode(CodeObject *code, SymbolTableStack *tableStack)
    {
    	
        std::vector<CodeLine *> threeAC = code->threeAC;

        {
	        for (auto code_line : threeAC)
	        {
	            std::string command = code_line->command;
	            {
	            	std::string new_arg1 = code_line->arg1;
	            	std::string new_arg2 = code_line->arg2;

		            if (command == "READI") {
		                assembly.push_back(new CodeLine(code_line->scope, "sys", "readi", new_arg1));
		            }
		            else if (command == "READF") {
		                assembly.push_back(new CodeLine(code_line->scope, "sys", "readr", new_arg1));
		            }
		            else if (command == "WRITEI") {
		                assembly.push_back(new CodeLine(code_line->scope, "sys", "writei", new_arg1));
		            }
		            else if (command == "WRITEF") {
		                assembly.push_back(new CodeLine(code_line->scope, "sys", "writer", new_arg1));
		            }
		            else if (command == "WRITES") {
		                assembly.push_back(new CodeLine(code_line->scope, "sys", "writes", new_arg1));
		            }
		            else if (command == "STOREI" || command == "STOREF") {
		                new_arg1 = isTemporary(code_line->arg1) ? getRegister(code_line->arg1) : new_arg1;
		                new_arg2 = isTemporary(code_line->arg2) ? getRegister(code_line->arg2) : new_arg2;
		                assembly.push_back(new CodeLine(code_line->scope, "move", new_arg1, new_arg2));
		            }
		            else {   
						std::string ops[] = {"GE", "GT", "LT", "LE", "NE", "EQ"};
						bool found = false;
						std::string tem_arg1 = isTemporary(code_line->arg1) ? getRegister(code_line->arg1) : code_line->arg1;
						std::string tem_arg2 = isTemporary(code_line->arg2) ? getRegister(code_line->arg2) : code_line->arg2;
						std::string tem_arg3 = isTemporary(code_line->arg3) ? getRegister(code_line->arg3) : code_line->arg3;
						for (auto i:ops) {
							if (i == command) {
								if (i[0] != '$') {
									std::string new_reg = getNewRegister();
									temp_to_reg[tem_arg2] = new_reg;
									assembly.push_back(new CodeLine(code_line->scope, "move", tem_arg2, new_reg));
									assembly.push_back(new CodeLine(code_line->scope, "cmpi", tem_arg1, new_reg));
								}
								else 
									assembly.push_back(new CodeLine(code_line->scope, "cmpi", tem_arg1, tem_arg2));
								assembly.push_back(new CodeLine(code_line->scope, "j"+toLower(command), tem_arg3));
								found = true;
								break;
							}
						}

						if (command == "JUMP") {
							assembly.push_back(new CodeLine(code_line->scope, "jmp", code_line->arg1));
							found = true;
						}
						else if (command == "LABEL") {
							assembly.push_back(new CodeLine(code_line->scope, "label", code_line->arg1));
							found = true;
						}

						if (found)
							continue;

						std::string command;
		                new_arg1 = isTemporary(code_line->arg1) ? getRegister(code_line->arg1) : new_arg1;
		                std::string arg2 = getNewRegister();
		                assembly.push_back(new CodeLine(code_line->scope, "move", new_arg1, arg2));

		                if (code_line->command == "ADDI")
		                    command = "addi";
		                else if (code_line->command == "SUBI")
		                    command = "subi";
		                else if (code_line->command == "MULTI")
		                    command = "muli";
		                else if (code_line->command == "DIVI")
		                    command = "divi";
		                else if (code_line->command == "ADDF")
		                    command = "addr";
		                else if (code_line->command == "SUBF")
		                    command = "subr";
		                else if (code_line->command == "MULTF")
		                    command = "mulr";
		                else if (code_line->command == "DIVF")
		                    command = "divr";

		                new_arg1 = isTemporary(code_line->arg2) ? getRegister(code_line->arg2) : new_arg2;
		                assembly.push_back(new CodeLine(code_line->scope, command, new_arg1, arg2));
		                if (isTemporary(code_line->arg3))
		                    temp_to_reg[code_line->arg3] = arg2;

		            }
		        }
	        }
	        
	    }
    }

    void printMap()
    {
        for (auto it: temp_to_reg)
            std::cout << it.first << " " << it.second << std::endl;
        std::cout << "PRINTED" << std::endl;
    }

    void print()
    {
        for (auto c: assembly)
            c->print();
    }

};

#endif
