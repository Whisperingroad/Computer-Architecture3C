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

	--lui (upper immediate bits)
	when "001111" => 
		ALUOp <= "11";
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
		ALUOp <= "11";
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

	--ADD,SUB, OR, NOR, SLT
	when "000000" =>
		ALUOp <= "10";
		Branch <= '0';
		Jump <= '0';
		MemRead <= '0';
		MemToReg <= '0';
		InstrtoReg <= '0';
		MemWrite <= '0';
		ALUSrc <= '0';
		SignExtend <= '0';
		RegWrite <= '1';
		RegDst <= '1';
	
	--beq
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

