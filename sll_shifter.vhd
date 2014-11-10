----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:38:27 10/07/2014 
-- Design Name: 
-- Module Name:    sll_shifter - Behavioral 
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

entity sll_shifter is
    Port ( Source : in  STD_LOGIC_VECTOR (31 downto 0);
				Command : in STD_LOGIC_VECTOR (1 downto 0);
           Shift_number : in  STD_LOGIC_VECTOR (4 downto 0);
           sll_output : out  STD_LOGIC_VECTOR (31 downto 0));
end sll_shifter;

architecture Behavioral of sll_shifter is

begin

process(Source, Command, shift_number)

variable temp_result : STD_LOGIC_VECTOR(31 DOWNTO 0);

begin


	temp_result := Source;

	
	case Command is
	
	--Logical shift left
	when "01" =>
		if Shift_number(0) = '1' then
			temp_result := temp_result(30 downto 0) & '0';
			end if;
		if Shift_number(1) = '1' then
			temp_result := temp_result(29 downto 0) & "00";
			end if;
		if Shift_number(2) = '1' then	
			temp_result := temp_result(27 downto 0) & x"0";
			end if;
		if Shift_number(3) = '1' then
			temp_result := temp_result(23 downto 0) & x"00";
			end if;
		if Shift_number(4) = '1' then
			temp_result := temp_result(15 downto 0) & x"0000";
			end if;
			
	when others =>
		-- do nothing
		
		end case;	
		sll_output <= temp_result;
		
end process;		

end Behavioral;

