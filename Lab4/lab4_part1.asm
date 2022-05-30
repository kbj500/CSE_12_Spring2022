
#Note that this file only contains a function xyCoordinatesToAddress
#As such, this function should work independent of any caller funmction which calls it
#When using regisetrs, you HAVE to make sure they follow the register usage convention in RISC-V as discussed in lectures.
#Else, your function can potentially fail when used by the autograder and in such a context, you will receive a 0 score for this part

xyCoordinatesToAddress:
	#(x,y) in (a0,a1) arguments
	#a2 argument contains base address
	#returns pixel address in a0
	
	#make sure to return to calling function after putting correct value in a0!
	#Enter code below!DO NOT MODIFY ANYTHING BEFORE THIS COMMENT LINE!

#loop for x coordinate, increments base address by a number of times for quantity in x	
loop_x: 
	#conditional is decrement until x quantity is at 0 then branch to y loop
	beq zero, a0, loop_y
	
	#increase base address by one 
	addi a2, a2, 4
	#decrement x quantity by 1
	addi a0, a0, -1
	b loop_x

#loop for y coordinate, executed after x coordinate loop finishes, increments base address by a number of times for quantity in y	
loop_y:
	#conditional is decrement until y quantity is at 0 then branch to exit
	beq zero, a1, xy_exit
	
	#increase base address by one	
	addi a2, a2, 128
	#decrement y quantity by 1
	addi a1, a1, -1
	b loop_y

xy_exit:
	#set a0 value to final base address 
	mv a0, a2
	ret
	
