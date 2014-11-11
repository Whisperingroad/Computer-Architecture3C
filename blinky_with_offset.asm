##sample program needed for CG3207 lab 3
	.text 	#the succeeding lines contain instructions
	.globl main #main is global symbol so that it is visible to other files for referencing
	
main :	
	start : 	lui $t1, 0x0000 
 			ori $t1, 0x0001 # constant 1 --lower half
 			#to test if offset works
 			#address of DIP switches is 1003 0000
 			#to test if offset works, just load in address as 1002 FFFF
 			#followed by loading the address, offset by one.
 			lui $t0, 0x1002 
 			ori $t0, 0xffff
			lw  $t4, 1($t0) 
			lui $t0, 0x1002 # LED pointer, for VHDL
	loop: 		lui $t2, 0x0000
			ori $t2, 0x0004 # delay counter (n). Change according to the clock			
			
	delay: 		sub $t2, $t2, $t1 
			slt $t3, $t2, $t1
			beq $t3, $zero, delay
			sw  $t4, 0($t0)	
			nor $t4, $t4, $zero
			j loop # infinite loop; n*3 (delay instructions) + 5 (non-delay instructions).
		
			