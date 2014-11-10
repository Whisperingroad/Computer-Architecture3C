----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:29:29 11/10/2014 
-- Design Name: 
-- Module Name:    Branch_MUX - Behavioral 
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

entity Branch_MUX is
    Port ( SignExtend : in STD_LOGIC_VECTOR (31 downto 0);
           PC_out : in STD_LOGIC_VECTOR (31 downto 0);
           ALU_greater : in  STD_LOGIC;
           ALU_zero : in  STD_LOGIC;
			  Branch : in STD_LOGIC;
           Switch: out STD_LOGIC_VECTOR;
end Branch_MUX;

architecture Behavioral of Branch_MUX is
signal Shifted	: STD_LOGIC_VECTOR (31 downto 0); 
begin

process(SignExtend,PC_out,ALU_greater,ALU_zero)
begin

Shifter <=  SignExtend(29 downto 0) & "00";
Shifter <= Shifter + PC_out; 
if (ALU_zero =1 and Branch = '1') then
	

end Behavioral;

