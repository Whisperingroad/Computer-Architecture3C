----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:21:54 10/07/2014 
-- Design Name: 
-- Module Name:    sra_shifter - Behavioral 
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

entity sra_shifter is
    Port ( Source : in  STD_LOGIC_VECTOR (31 downto 0);
           Command : in  STD_LOGIC_VECTOR (1 downto 0);
           Shift_number : in  STD_LOGIC_VECTOR (4 downto 0);
           sra_output : out  STD_LOGIC_VECTOR (31 downto 0));
end sra_shifter;

architecture Behavioral of sra_shifter is

begin
process (Source, Command, shift_number)

variable temp_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
variable MSB : STD_LOGIC;

begin


	temp_result := Source;

	Case Command is
	
	-- Shift right arithmetic
	when "10" =>
		MSB := Source(31);
		
		if Shift_number(0) = '1' then
			temp_result(30 downto 0) := temp_result(31 downto 1);
			temp_result(31) := MSB;
			end if;
		if Shift_number(1) = '1' then
			temp_result(29 downto 0) := temp_result(31 downto 2);
			temp_result(31 downto 30) := (others => MSB);
			end if;
		if Shift_number(2) = '1' then
			temp_result(27 downto 0) := temp_result(31 downto 4);
			temp_result(31 downto 28) := (others => MSB);
			end if;
		if Shift_number(3) = '1' then
			temp_result(23 downto 0) := temp_result(31 downto 8);
			temp_result(31 downto 24) := (others => MSB);	
			end if;
		if Shift_number(4) = '1' then	
			temp_result(15 downto 0) := temp_result(31 downto 16);
			temp_result(31 downto 16) := (others => MSB);
			end if;

	when others =>
		
			--do nothing
	end case;
		sra_output <= temp_result;
	
end process;
end Behavioral;

