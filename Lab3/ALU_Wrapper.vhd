----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:30:35 11/08/2014 
-- Design Name: 
-- Module Name:    ALU_Wrapper - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



entity ALU_Wrapper is
    Port ( 
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
			  		
end ALU_Wrapper;

architecture Behavioral of ALU_Wrapper is

----------------------------------------------------------------
-- ALU 
----------------------------------------------------------------
component ALU is
    Port (
			Clk			: in	STD_LOGIC;
			Operand1 		: in  STD_LOGIC_VECTOR (31 downto 0);				
			Operand2 		: in  STD_LOGIC_VECTOR (31 downto 0);
			Result1		: out	STD_LOGIC_VECTOR (31 downto 0);
			Result2		: out	STD_LOGIC_VECTOR (31 downto 0);
			Status		: out	STD_LOGIC_VECTOR (2 downto 0);
			ALU_Control	: out  STD_LOGIC_VECTOR (5 downto 0);
			ALU_zero		: out STD_LOGIC;
			ALU_greater	: out STD_LOGIC);
end component;

----------------------------------------------------------------
-- ALU Signals
----------------------------------------------------------------
signal	ALU_Control	:  STD_LOGIC_VECTOR (5 downto 0);		

begin
----------------------------------------------------------------
-- ALU port map
----------------------------------------------------------------
ALU1 				: ALU port map
						(
						Clk			=> Clk,
						Operand1 	=> ALU_InA, 
						Operand2 	=> ALU_InB, 
						Result1     => Result1,
						Result2     => Result2,
						Status      => Status,
						ALU_Control => ALU_Control,
						ALU_zero  	=> ALU_zero,
						ALU_greater => ALU_greater
						);
----------------------------------------------------------------
--logic code
----------------------------------------------------------------

process(Control,ALU_InA,ALU_InB)
begin
case Control(7 downto 6) is --ALU_Op
when "00" => --memory instructions lw/sw
	
	case Control(5 downto 0) is --funct
	when "001000" => ALU_control <= Control(5) & "" ; --addi
	when "001101" => ALU_control <= Control(5) & "" ; --ori
	when "001111" => ALU_control <= Control(5) & "" ; --lui
	when others => ALU_control <= Control (5 downto 0); --lw/sw
	end case;

when "01" => --branch instructions	

	case Control(5 downto 0) is --funct
	when "000100" => ALU_control <= Control(5) & "" ; --beq
	when "000001" => ALU_control <= Control(5) & "" ; --bgez /bgezal
	when "001111" => ALU_control <= Control(5) & "" ; --lui
	when others => 
	end case;
	
when "10" => -- R-type

	case Control(5 downto 0) is --funct
	when "100000" => ALU_control <= Control(5) & "00010" ; --add
	when "100010" => ALU_control <= Control(5) & "00110" ; --sub
	when "100100" => ALU_control <= Control(5) & "00000" ; --and
	when "100101" => ALU_control <= Control(5) & "00001" ; --or
	when "100110" => ALU_control <= Control(5) & "00111" ; --slt
	when "100111" => ALU_control <= Control(5) & "01100" ; --nor
	when "011000" => ALU_control <= Control(5) & "10000" ; --mult
	when "011001" => ALU_control <= Control(5) & "10001" ; --multu
	when "010000" => ALU_control <= Control(5) & "" ; --mfhi
	when "010010" => ALU_control <= Control(5) & "" ; --mflo
	when "000000" => ALU_control <= Control(5) & "00101" ; --sll
	when "000011" => ALU_control <= Control(5) & "01001" ; --sra
	when "000010" => ALU_control <= Control(5) & "01101" ; --srl
	when "000100" => ALU_control <= Control(5) & "" ; --sllv
	when "101001" => ALU_control <= Control(5) & "01110" ; --sltu
	when "000011" => ALU_control <= Control(5) & "01001" ; --sra
	when "000000" => ALU_control <= Control(5) & "" ; --jr
	when others =>
	end case;

when others => ALU_control <= Control(5) & "XXXXX"; --j/jal 
end case;

end process;
end Behavioral;

