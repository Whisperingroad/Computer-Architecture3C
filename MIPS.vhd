----------------------------------------------------------------------------------
-- Company: NUS
-- Engineer: Rajesh Panicker
-- 
-- Create Date:   21:06:18 14/10/2014
-- Design Name: 	MIPS
-- Target Devices: Nexys 4 (Artix 7 100T)
-- Tool versions: ISE 14.7
-- Description: MIPS processor
--
-- Dependencies: PC, ALU, ControlUnit, RegFile
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: DO NOT modify the interface (entity). Implementation (architecture) can be modified.
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity MIPS is -- DO NOT modify the interface (entity)
    Port ( 	
			Addr_Instr 		: out STD_LOGIC_VECTOR (31 downto 0);
			Instr 			: in STD_LOGIC_VECTOR (31 downto 0);
			Addr_Data		: out STD_LOGIC_VECTOR (31 downto 0);
			Data_In			: in STD_LOGIC_VECTOR (31 downto 0);
			Data_Out			: out  STD_LOGIC_VECTOR (31 downto 0);
			MemRead 			: out STD_LOGIC; 
			MemWrite 		: out STD_LOGIC; 
			RESET				: in STD_LOGIC;
			CLK				: in STD_LOGIC
			);
end MIPS;


architecture arch_MIPS of MIPS is

----------------------------------------------------------------
-- Program Counter
----------------------------------------------------------------
component PC is
	Port(	
			PC_in 	: in STD_LOGIC_VECTOR (31 downto 0);
			PC_out 	: out STD_LOGIC_VECTOR (31 downto 0);
			RESET		: in STD_LOGIC;
			CLK		: in STD_LOGIC);
end component;




----------------------------------------------------------------
-- ALU  WRAPPER
----------------------------------------------------------------
component ALU_Wrapper is
	Port(	
		     Clk : in STD_LOGIC;
			  ALU_InA : in  STD_LOGIC_VECTOR(31 downto 0);
           ALU_InB : in  STD_LOGIC_VECTOR(31 downto 0);
           Control : in  STD_LOGIC(7 downto 0);
			  Result1 : out  STD_LOGIC (31 downto 0);
           Result2 : out STD_LOGIC (31 downto 0);
           Operand1 : out  STD_LOGIC_VECTOR(31 downto 0);
           Operand2 : out  STD_LOGIC_VECTOR(31 downto 0);
           Status	 : out  STD_LOGIC(2 downto 0);
			  ALU_zero		: out STD_LOGIC;
			  ALU_greater	: out STD_LOGIC);
	   
end component;

--end component;

--component alu is
--generic (width 	: integer);
--Port (Clk			: in	STD_LOGIC;
--		Control		: in	STD_LOGIC_VECTOR (5 downto 0);
--		Operand1		: in	STD_LOGIC_VECTOR (width-1 downto 0);
--		Operand2		: in	STD_LOGIC_VECTOR (width-1 downto 0);
--		Result1		: out	STD_LOGIC_VECTOR (width-1 downto 0);
--		Result2		: out	STD_LOGIC_VECTOR (width-1 downto 0);
--		Status		: out	STD_LOGIC_VECTOR (2 downto 0); -- busy (multicycle only), overflow (add and sub), zero (sub)
--		Debug			: out	STD_LOGIC_VECTOR (width-1 downto 0));		
--end component alu;

----------------------------------------------------------------
-- Control Unit
----------------------------------------------------------------
component ControlUnit is
    Port ( 	
			opcode 		: in   STD_LOGIC_VECTOR (5 downto 0);
			ALUOp 		: out  STD_LOGIC_VECTOR (1 downto 0);
			Branch 		: out  STD_LOGIC;
			Jump	 		: out  STD_LOGIC;				
			MemRead 		: out  STD_LOGIC;	
			MemtoReg 	: out  STD_LOGIC;	
			InstrtoReg	: out  STD_LOGIC; -- true for LUI. When true, Instr(15 downto 0)&x"0000" is written to rt
			MemWrite		: out  STD_LOGIC;	
			ALUSrc 		: out  STD_LOGIC;	
			SignExtend 	: out  STD_LOGIC; -- false for ORI 
			RegWrite		: out  STD_LOGIC;	
			RegDst		: out  STD_LOGIC);
end component;

----------------------------------------------------------------
-- Register File
----------------------------------------------------------------
component RegFile is
    Port ( 	
			ReadAddr1_Reg 	: in  STD_LOGIC_VECTOR (4 downto 0);
			ReadAddr2_Reg 	: in  STD_LOGIC_VECTOR (4 downto 0);
			ReadData1_Reg 	: out STD_LOGIC_VECTOR (31 downto 0);
			ReadData2_Reg 	: out STD_LOGIC_VECTOR (31 downto 0);				
			WriteAddr_Reg	: in  STD_LOGIC_VECTOR (4 downto 0); 
			WriteData_Reg 	: in STD_LOGIC_VECTOR (31 downto 0);
			RegWrite 		: in STD_LOGIC; 
			CLK 				: in  STD_LOGIC);
end component;

----------------------------------------------------------------
-- Sign Extend
----------------------------------------------------------------
component Sign_Extend is
    Port ( signExtendInput : in  STD_LOGIC_VECTOR (15 downto 0);
           signExtendOutput : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
----------------------------------------------------------------
-- PC Signals
----------------------------------------------------------------
	signal	PC_in 		:  STD_LOGIC_VECTOR (31 downto 0);
	signal	PC_out 		:  STD_LOGIC_VECTOR (31 downto 0);

----------------------------------------------------------------
-- ALU Signals
----------------------------------------------------------------
	signal	ALU_InA 		:  STD_LOGIC_VECTOR (31 downto 0);
	signal	ALU_InB 		:  STD_LOGIC_VECTOR (31 downto 0);
	signal	ALU_Control	:  STD_LOGIC_VECTOR (7 downto 0);
	signal   Control     :  STD_LOGIC(7 downto 0);

	signal	Operand1		: STD_LOGIC_VECTOR (width-1 downto 0) 	:= (others=>'0');
	signal	Operand2		: STD_LOGIC_VECTOR (width-1 downto 0) 	:= (others=>'0');
	signal	Result1		: STD_LOGIC_VECTOR (width-1 downto 0) 	:= (others=>'0');
	signal	Result2		: STD_LOGIC_VECTOR (width-1 downto 0) 	:= (others=>'0');
	signal	Status		: STD_LOGIC_VECTOR (2 downto 0) 			:= (others=>'0');
	signal  ALU_zero		: STD_LOGIC := '0';
   signal  ALU_greater	: STD_LOGIC := '0';
	
----------------------------------------------------------------
-- Control Unit Signals
----------------------------------------------------------------				
 	signal	opcode 		:  STD_LOGIC_VECTOR (5 downto 0);
	signal	ALUOp 		:  STD_LOGIC_VECTOR (1 downto 0);
	signal	Branch 		:  STD_LOGIC;
	signal	Jump	 		:  STD_LOGIC;	
	signal	MemtoReg 	:  STD_LOGIC;
	signal 	InstrtoReg	: 	STD_LOGIC;		
	signal	ALUSrc 		:  STD_LOGIC;	
	signal	SignExtend 	: 	STD_LOGIC;
	signal	RegWrite		: 	STD_LOGIC;	
	signal	RegDst		:  STD_LOGIC;

----------------------------------------------------------------
-- Register File Signals
----------------------------------------------------------------
 	signal	ReadAddr1_Reg 	:  STD_LOGIC_VECTOR (4 downto 0);
	signal	ReadAddr2_Reg 	:  STD_LOGIC_VECTOR (4 downto 0);
	signal	ReadData1_Reg 	:  STD_LOGIC_VECTOR (31 downto 0);
	signal	ReadData2_Reg 	:  STD_LOGIC_VECTOR (31 downto 0);
	signal	WriteAddr_Reg	:  STD_LOGIC_VECTOR (4 downto 0); 
	signal	WriteData_Reg 	:  STD_LOGIC_VECTOR (31 downto 0);
	
----------------------------------------------------------------
-- Sign Extend
----------------------------------------------------------------
	signal	signExtendin 		:  STD_LOGIC_VECTOR (15 downto 0);
	signal	signExtendout		:  STD_LOGIC_VECTOR (31 downto 0);
----------------------------------------------------------------
-- Other Signals
----------------------------------------------------------------
	--<any other signals used goes here>
 

----------------------------------------------------------------	
----------------------------------------------------------------
-- <MIPS architecture>
----------------------------------------------------------------
----------------------------------------------------------------
begin

----------------------------------------------------------------
-- PC port map
----------------------------------------------------------------
PC1				: PC port map
						(
						PC_in 	=> PC_in, 
						PC_out 	=> PC_out, 
						RESET 	=> RESET,
						CLK 		=> CLK
						);
						
----------------------------------------------------------------
-- ALU port map
----------------------------------------------------------------
ALU_Wrapper				: ALU_Wrapper port map
						(
						Clk => Clk,
						ALU_InA 	=> ALU_InA, 
						ALU_InB 	=> ALU_InB, 
						Control => Control, 
					   Operand1 => Operand1,
						Operand2	=> Operand2,
						Result1 => Result1,
						Result2 => Result2,
						Status => Status,
						ALU_zero => ALU_zero,
						ALU_greater => ALU_greater
						);
					
----------------------------------------------------------------
-- PC port map
----------------------------------------------------------------
ControlUnit1 	: ControlUnit port map
						(
						opcode 		=> opcode, 
						ALUOp 		=> ALUOp, 
						Branch 		=> Branch, 
						Jump 			=> Jump, 
						MemRead 		=> MemRead, 
						MemtoReg 	=> MemtoReg, 
						InstrtoReg 	=> InstrtoReg, 
						MemWrite 	=> MemWrite, 
						ALUSrc 		=> ALUSrc, 
						SignExtend 	=> SignExtend, 
						RegWrite 	=> RegWrite, 
						RegDst 		=> RegDst
						);
						
----------------------------------------------------------------
-- Register file port map
----------------------------------------------------------------
RegFile1			: RegFile port map
						(
						ReadAddr1_Reg 	=>  ReadAddr1_Reg,
						ReadAddr2_Reg 	=>  ReadAddr2_Reg,
						ReadData1_Reg 	=>  ReadData1_Reg,
						ReadData2_Reg 	=>  ReadData2_Reg,
						WriteAddr_Reg 	=>  WriteAddr_Reg,
						WriteData_Reg 	=>  WriteData_Reg,
						RegWrite 		=> RegWrite,
						CLK 				=> CLK				
						);

----------------------------------------------------------------
-- SignExtend port map
----------------------------------------------------------------
SignExtend1 				: Sign_Extend port map
						(
						signExtendInput => signExtendin, 
						signExtendOutput => signExtendout 						
						);
						

----------------------------------------------------------------
-- Processor logic
----------------------------------------------------------------
--<Rest of the logic goes here>

--Fetching of instructions accounted for by PC1

--Decoding instructions for Control Unit
opcode <= Instr(31 downto 26);
ReadAddr1_Reg <= Instr(25 downto 21); 
ReadAddr2_Reg <= Instr(20 downto 16);


--SignExtend for address offset
--for load and store operations
signExtendin <= Instr(15 downto 0);


--Inputs for ALU
ALU_Control <= ALUOp & Instr(5 downto 0);

--Unconditional
ALU_InA  <= ReadData1_Reg;

--for R type and BEQ operations 

ALU_InB <= ReadData2_Reg when ALUSrc = '0' else
--ALUSrc = 1 
Instr(15 downto 0)& x"0000" when InstrtoReg = '1' else -- LUI
--x"0000" & Instr(15 downto 0) when ALUOp = "11" and InstrtoReg = '0' else --ORI
x"0000" & Instr(15 downto 0) when SignExtend = '0' else -- ORI
signExtendout; -- LW/SW

--PC
PC_in <= PC_out + (signExtendout(29 downto 0) & "00")  when Branch = '1' and ALU_zero = '1' else -- Branch (beq) 
PC_out(31 downto 28) &(Instr(25 downto 0)& "00") when Jump = '1' else --Jump
PC_out; -- R-type / Lw/ Sw

--RegFile
WriteAddr_Reg <= Instr(20 downto 16) when RegDst = '0' else -- choose rt or rd
Instr(15 downto 11);
WriteData_Reg <= ALU_Out when MemtoReg = '0' else -- choose rt or rd
DATA_In; 

--Output to top file
Addr_Instr <= PC_out;
Addr_Data <= ALU_Out;
Data_Out <= ReadData2_Reg;
 


end arch_MIPS;

----------------------------------------------------------------	
----------------------------------------------------------------
-- </MIPS architecture>
----------------------------------------------------------------
----------------------------------------------------------------	
