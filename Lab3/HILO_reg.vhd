----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:07:12 11/11/2014 
-- Design Name: 
-- Module Name:    HILO_reg - Behavioral 
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

entity HILO_reg is
    Port ( ReadHi_Reg : out  STD_LOGIC_VECTOR (31 downto 0);
           ReadLo_Reg : out  STD_LOGIC_VECTOR (31 downto 0);
           WriteHi_Reg : in  STD_LOGIC_VECTOR (31 downto 0);
           WriteLo_Reg : in  STD_LOGIC_VECTOR (31 downto 0);
           RegHiLoWrite : in  STD_LOGIC; --enable
           CLK : in  STD_LOGIC);
end HILO_reg;

architecture Behavioral of HILO_reg is

signal reg_Hi : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
signal reg_Lo : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');

begin

--asynchronous reads
ReadHi_Reg <= reg_Hi;
ReadLo_Reg <= reg_Lo;

process (CLK, WriteHi_Reg, WriteLo_Reg, RegHiLoWrite)

begin

if (CLK'event and CLK = '1') then
	if RegHiLoWrite = '1' then
			reg_Hi <= WriteHi_Reg;
			reg_Lo <= WriteLo_Reg;
	--else
		--do nothing
	end if;	
		-- do nothing	
end if;			
end process;

end Behavioral;

