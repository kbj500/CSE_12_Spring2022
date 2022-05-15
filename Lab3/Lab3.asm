
##########################################################################
# Created by: 	Khadka, Bijaya
#		bkhadka		  
#		15 May, 2022
#		
# Assignment:	Lab 64: Super Hello World
#		CMPE 012, Computer Systems and Assembly Language
#		UC Santa Cruz, Spring 2022
#
# Description:	This program prints a patttern  with numbers and stars (asterisks) and dollar
#		signs ($) when a number (non-negative integer greater than 0) is entered.
#
# Notes: This program is intended to be run from the RARS IDE
##########################################################################
#
# REGISTER USAGE
# t0: user input
# t2: first loop counter
# t3: second loop counter
##########################################################################

 .macro print_str(%string1)	# macro to print any string
	li a7,4 
	la a0, %string1
	ecall
	.end_macro

.macro print_odd (%x)		# macro to print the odd number at the end of each pattern line
	li a7, 1		
	add a0, zero, %x
	add a0, a0, a0
	addi x2, zero, 1
	sub a0, a0, x2

	ecall
	.end_macro

.macro check_int (%x)  		# macro to check int greater than zero
	bgtz %x, cont
	li a7,4 
	la a0, prompt2
	ecall
	
	li a7,4 
	la a0, newline
	ecall

	j ask_height
cont:				# begins pattern if check is passed
	j start
	.end_macro

.data 						

	prompt1: .asciz  "Enter the height of the pattern (must be greater than 0):"
	prompt2: .asciz  "Invalid Entry!"
	dollar: .asciz  "$"
	ast: .asciz "*"
	newline: .asciz  "\n" 	# this prints a newline

#-------End of .data section!---------

.text 				


main: 				# main program.

				
ask_height:			# print prompt1 string on console
	li a7,4 
	la a0, prompt1
	ecall

				
	li a7, 5		# read in integer
	ecall 		

	check_int(a0)		# check integer is non-negative


start:				# begin pattern output
	addi t0, a0, 0		# t0 = a0 + 1, a0 copied to t0

	


	li t2, 1		# t2 will be loop counter i
				# will iterate from i=0 till t2>t0
	
	li t3, 1		# t3 with be loop counter j
				# will iterate from i=0 till t3>t2
	
loop_body_1:
	bgt t2, t0, loop_exit_1	# execute only if t2<=t0
				# else jump to loop_exit_1
	
			
	print_str(dollar)	# output first dollar character 

loop_body_2:			
	bge t3, t2, loop_exit_2	# execute only if t3<=t2
				# else jump to loop_exit_2
	print_str(ast)		# output following asterisk and dollar characters
	print_str(dollar)

loop_update_2:			# update loop increment
	
	addi t3, t3, 1
	#i=i+1
	b loop_body_2		# jump back to loop

loop_exit_2:			# set loop increment register value to zero
	
	addi t3, zero, 1

loop_update_1:			# output odd number at end of pattern
	print_odd(t2)

	addi t2, t2, 1		#i=i+1
	
	li a7,4 
	la a0, newline		# newline for next pattern line
	ecall

	b loop_body_1

loop_exit_1:
				#done with loop. Phew!
	li a7, 10 	
	ecall 
	

#-------End of .text section!---------

#For the list of available instructions, go to: 
#Help -> Help -> RISCV -> Basic Instructions
#Help -> Help -> RISCV -> Extended (pseudo) Instructions

#RUN INSTRUCTIONS
#Click Assemble (Wrench and screwdiver icon)
#If the Run Buttom becomes green , assembly is successful
#Click on the Run button

