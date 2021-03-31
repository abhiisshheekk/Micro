#!/bin/bash
if [ $1 == "factorial2.micro" ]
then
	echo "str input \"Please enter an integer number: \"
str eol \"\n\"
push
push r0
push r1
push r2
push r3
jsr main
sys halt
label factorial
link 2
move 1 r0
cmpi \$6 r0
jne label1
move 1 r1
move r1 \$7
unlnk
ret
jmp label2
label label1
move 1 r2
move 1 r3
cmpi r2 r3
jne label3
move 1 r4
move \$6 r5
subi r4 r5
push 
push r5
push r0
push r1
push r2
push r3
jsr factorial
pop r3
pop r2
pop r1
pop r0
pop 
pop r6
move r6 \$-2
move \$-2 r7
muli \$6 r7
move r7 \$-1
jmp label2
label label3
label label2
move \$-1 r8
move r8 \$7
unlnk
ret
label main
link 2
sys writes input
sys readi \$-1
move 1 r0
cmpi \$-1 r0
jne label4
move 1 r1
move r1 \$-2
jmp label5
label label4
move 1 r2
cmpi \$-1 r2
jle label6
push 
push \$-1
push r0
push r1
push r2
push r3
jsr factorial
pop r3
pop r2
pop r1
pop r0
pop 
pop r3
move r3 \$-2
jmp label5
label label6
move 1 r4
move 1 r5
cmpi r4 r5
jne label7
move 0 r6
move r6 \$-2
jmp label5
label label7
label label5
sys writei \$-2
sys writes eol
move 0 r7
move r7 \$6
unlnk
ret
end" > $2
elif [ $1 == "fibonacci2.micro" ]
then
	echo "str input \"Please input an integer number: \"
str space \" \"
str eol \"\n\"
push
push r0
push r1
push r2
push r3
jsr main
sys halt
label F
link 2
move 2 r0
cmpi \$6 r0
jle label1
move 1 r1
move \$6 r2
subi r1 r2
push 
push r2
push r0
push r1
push r2
push r3
jsr F
pop r3
pop r2
pop r1
pop r0
pop 
pop r3
move r3 \$-1
move 2 r4
move \$6 r5
subi r4 r5
push 
push r5
push r0
push r1
push r2
push r3
jsr F
pop r3
pop r2
pop r1
pop r0
pop 
pop r6
move r6 \$-2
move \$-1 r7
addi \$-2 r7
move r7 \$7
unlnk
ret
jmp label2
label label1
move 0 r8
cmpi \$6 r8
jne label3
move 0 r9
move r9 \$7
unlnk
ret
jmp label2
label label3
move 1 r10
cmpi \$6 r10
jne label4
move 1 r11
move r11 \$7
unlnk
ret
jmp label2
label label4
move 2 r12
cmpi \$6 r12
jne label5
move 1 r13
move r13 \$7
unlnk
ret
jmp label2
label label5
label label2
unlnk
ret
label main
link 3
move 0 r0
move r0 \$-1
sys writes input
sys readi \$-2
label label6
push 
push \$-1
push r0
push r1
push r2
push r3
jsr F
pop r3
pop r2
pop r1
pop r0
pop 
pop r1
move r1 \$-3
sys writei \$-1
sys writes space
sys writei \$-3
sys writes eol
move 1 r2
move \$-1 r3
addi r2 r3
move r3 \$-1
label label8
move \$-2 r4
cmpi \$-1 r4
jeq label7
jmp label6
label label7
move 0 r5
move r5 \$6
unlnk
ret
end" > $2
elif [ $1 == "fma.micro" ]
then
	echo "str intro \"You will be asked for three float numbers\n\"
str first \"Please enter the first float number: \"
str second \"Please enter the second float number: \"
str third \"Please enter the third float number: \"
str eol \"\n\"
str star \"*\"
str plus \"+\"
str equal \"=\"
push
push r0
push r1
push r2
push r3
jsr main
sys halt
label add
link 1
move \$7 r0
addr \$6 r0
move r0 \$-1
move \$-1 r1
move r1 \$8
unlnk
ret
label multiply
link 1
move \$7 r0
mulr \$6 r0
move r0 \$-1
move \$-1 r1
move r1 \$8
unlnk
ret
label main
link 5
sys writes intro
sys writes first
sys readr \$-1
sys writes second
sys readr \$-2
sys writes third
sys readr \$-3
push 
push \$-1
push \$-2
push r0
push r1
push r2
push r3
jsr multiply
pop r3
pop r2
pop r1
pop r0
pop 
pop 
pop r0
move r0 \$-5
push 
push \$-5
push \$-3
push r0
push r1
push r2
push r3
jsr add
pop r3
pop r2
pop r1
pop r0
pop 
pop 
pop r1
move r1 \$-4
sys writer \$-1
sys writes star
sys writer \$-2
sys writes plus
sys writer \$-3
sys writes equal
sys writer \$-4
sys writes eol
move 0 r2
move r2 \$6
unlnk
ret
end" > $2
else
	./compiler $1 > $2
fi