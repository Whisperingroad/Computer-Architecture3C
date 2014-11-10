----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:43:10 11/10/2014 
-- Design Name: 
-- Module Name:    Jump_MUX - Behavioral 
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

entity Jump_MUX is
    Port ( Branch : in STD_LOGIC_VECTOR (31 downto 0);
           Jump : in STD_LOGIC_VECTOR (31 downto 0);
           Jump_control : in  STD_LOGIC;
           Jump_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Jump_MUX;

architecture Behavioral of Jump_MUX is

begin
process(Branch,Jump,Jump_control)
begin

if Jump_control = '1' then
Jump_out <= Jump;

else
Jump_out <= Branch;
end if;

end process;
end Behavioral;

