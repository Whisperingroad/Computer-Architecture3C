----------------------------------------------------------------------------------
-- Company: NUS
-- Engineer: Rajesh Panicker
-- 
-- Create Date:   21:06:18 14/10/2014
-- Design Name: 	ControlUnit
-- Target Devices: Nexys 4 (Artix 7 100T)
-- Tool versions: ISE 14.7
-- Description: Control Unit for the basic MIPS processor
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: The interface (entity) as well as implementation (architecture) can be modified
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity ControlUnit is
    Port ( 	opcode 		: in  STD_LOGIC_VECTOR (5 downto 0);
				ALUOp 		: out  STD_LOGIC_VECTOR (1 downto 0);
				Branch 		: out  STD_LOGIC := '0';		
				Jump	 		: out  STD_LOGIC := '0';	
				MemRead 		: out  STD_LOGIC := '0';
				MemtoReg 	: out  STD_LOGIC := '0';	
				InstrtoReg	: out STD_LOGIC := '0';
				MemWrite		: out  STD_LOGIC := '0';	
				ALUSrc 		: out  STD_LOGIC := '0';
				SignExtend 	: out  STD_LOGIC := '0';
				RegWrite		: out  STD_LOGIC := '0';	
				RegDst		: out  STD_LOGIC:= '0');
end ControlUnit;


architecture arch_ControlUnit of ControlUnit is  
begin  

process(opcode) 
begin 

	case opcode is 
	
	--lw
	when "100011" =>
		ALUOp <= "00";
		Branch <= '0';
		Jump <= '0';
		MemRead <= '1';
		MemToReg <= '1';
		InstrtoReg <= '0';
		MemWrite <= '0';
		ALUSrc <= '1';
		SignExtend <= '1';
		RegWrite <= '1';
		RegDst <= '0';
		
	--sw
	when "101011" => 
	
		ALUOp <= "00";
		Branch <= '0';
		Jump <= '0';
		MemRead <= '0';
		MemToReg <= 'X';
		InstrtoReg <= '0';
		MemWrite <= '1';
		ALUSrc <= '1';
		SignExtend <= '1';
		RegWrite <= '0';
		RegDst <= 'X';		


	--addi
	when "001000" =>
		ALUOp <= "00";
		Branch <= '0';
		Jump <= '0';
		MemRead <= '0';
		MemToReg <= '0';
		InstrtoReg <= '0';
		MemWrite <= '0';
		ALUSrc <= '0';
		SignExtend <= '1';
		RegWrite <= '1';
		RegDst <= '1';


	--lui (upper immediate bits)
	when "001111" => 
		--ALUOp <= "11";
		ALUOp <= "00";
		Branch <= '0';
		Jump <= '0';
		MemRead <= '0';
		MemToReg <= '0';
		InstrtoReg <= '1'; --only for lui
		MemWrite <= '0';
		ALUSrc <= '1';
		SignExtend <= '0';
		RegWrite <= '1';
		RegDst <= '0';	

	--ori
	when "001101" => 
		--ALUOp <= "11";
		ALUOp <= "00";
		Branch <= '0';
		Jump <= '0';
		MemRead <= '0';
		MemToReg <= '0';
		InstrtoReg <= '0';
		MemWrite <= '0';
		ALUSrc <= '1';
		SignExtend <= '0';
		RegWrite <= '1';
		RegDst <= '0';
		
	--slti
	when "001010" =>
		ALUOp <= "00";
		Branch <= '0';
		Jump <= '0';
		MemRead <= '0';
		MemToReg <= '0';
		InstrtoReg <= '0';
		MemWrite <= '0';
		ALUSrc <= '1';
		SignExtend <= '1';
		RegWrite <= '1';
		RegDst <= '0';
		


	--ADD,SUB, OR, NOR, SLT , MULT, MULTU, MFHI, MFLO, SLL, SRA, SRL, SLLV, SLTU, JR
	-- jr The jr instruction loads the PC register with a value stored in a register. (Rtype)

	when "000000" =>
		ALUOp <= "10";
		Branch <= '0';
		Jump <= '0' ;
		MemRead <= '0';
		MemToReg <= '0';
		InstrtoReg <= '0';
		MemWrite <= '0';
		ALUSrc <= '0';
		SignExtend <= '0';
		RegWrite <= '1';
		RegDst <= '1';


	--beq   Branch if rs and rt are equal. If rs = rt, PC ? PC + 4 + imm.
	when "000100" =>
		ALUOp <= "01";
		Branch <= '1';
		Jump <= '0';
		MemRead <= '0';
		MemToReg <= 'X';
		InstrtoReg <= '0';
		MemWrite <= '0';
		ALUSrc <= '0';
		SignExtend <= '1';
		RegWrite <= '0';
		RegDst <= 'X';

	--bgez / bgezal  
	--Branch if rs is greater than or equal to zero. If rs = 0, PC ? PC + 4 + imm.
	--Branch on Greater Than or Equal to Zero and Link
	when "000001" =>
		ALUOp <= "01";
		Branch <= '1';
		Jump <= '0';
		MemRead <= '0';
		MemToReg <= 'X';
		InstrtoReg <= '0';
		MemWrite <= '0';
		ALUSrc <= '0';
		SignExtend <= '1';
		RegWrite <= '0';
		RegDst <= 'X';
		
--	--bgezal  Branch on Greater Than or Equal to Zero and Link
--	when "000001" =>
--		ALUOp <= "01";
--		Branch <= '1';
--		Jump <= '0';
--		MemRead <= '0';
--		MemToReg <= '0';
--		InstrtoReg <= '0';
--		MemWrite <= '0';
--		ALUSrc <= '0';
--		SignExtend <= '1';
--		RegWrite <= '1';
--		RegDst <= '1';

	--j 
	when "000010" =>
		ALUOp <= "XX";
		Branch <= '0';
		Jump <= '1';
		MemRead <= '0';
		MemToReg <= 'X';
		InstrtoReg <= '0';
		MemWrite <= '0';
		ALUSrc <= 'X';
		SignExtend <= '0';
		RegWrite <= '0';
		RegDst <= 'X';


	--jal  Like the j instruction, except that the return address is loaded into the $ra register.
	when "000011" =>
		ALUOp <= "XX";
		Branch <= '0';
		Jump <= '1';
		MemRead <= '0';
		MemToReg <= 'X';
		InstrtoReg <= '0';
		MemWrite <= '0';
		ALUSrc <= 'X';
		SignExtend <= '0';
		RegWrite <= '1';
		RegDst <= '0';

	when others =>
		ALUOp <= "XX";
		Branch <= '0';
		Jump <= '0';
		MemRead <= '0';
		MemToReg <= 'X';
		InstrtoReg <= '0';
		MemWrite <= '0';
		ALUSrc <= 'X';
		SignExtend <= 'X';
		RegWrite <= '0';
		RegDst <= 'X';


	end case;
end process;
end arch_ControlUnit;



