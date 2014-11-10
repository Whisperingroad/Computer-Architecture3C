----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:53:08 10/07/2014 
-- Design Name: 
-- Module Name:    srl_shifter - Behavioral 
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

entity srl_shifter is
    Port ( Source : in  STD_LOGIC_VECTOR (31 downto 0);
           Command : in  STD_LOGIC_VECTOR (1 downto 0);
           Shift_number : in  STD_LOGIC_VECTOR (4 downto 0);
           srl_output : out  STD_LOGIC_VECTOR (31 downto 0));
end srl_shifter;

architecture Behavioral of srl_shifter is

begin

process(Source, Command, shift_number)

variable temp_result : STD_LOGIC_VECTOR(31 DOWNTO 0);


begin

	
	temp_result := Source;


	case Command is
	
	
	--Logical shift right 
	when "11" =>
	
		if Shift_number(0) = '1' then
			temp_result :=  '0' & temp_result(31 downto 1);
			end if;
		if Shift_number(1) = '1' then
			temp_result:= "00" & temp_result(31 downto 2);
			end if;
		if Shift_number(2) = '1' then
			temp_result:= x"0" & temp_result(31 downto 4);
			end if;
		if Shift_number(3) = '1' then
			temp_result:= x"00" & temp_result(31 downto 8);
			end if;
		if Shift_number(4) = '1' then
			temp_result:= x"0000" & temp_result(31 downto 16);
			end if;
			
	when others =>
	-- do nothing
	end case;
	
	srl_output <= temp_result;

end process;	
end Behavioral;

