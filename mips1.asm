##sample program needed for CG3207 lab 3
	.text 	#the succeeding lines contain instructions
	.globl main #main is global symbol so that it is visible to other files for referencing
	
main :
	lui $t1, 0x0FFF #loads the upper 16 bits of t1 with the 16 bit immediate value, and the lower 16 bits with all 0's
	ori $t1, $t1, 0xFFFF #ori zero extends the immediate value, behaves like an unsigned addition	
	
	