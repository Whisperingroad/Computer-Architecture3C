----------------------------------------------------------------------------------
-- Company: NUS
-- Engineer: Rajesh Panicker
-- 
-- Create Date:   21:06:18 14/10/2014
-- Design Name: 	RegFile
-- Target Devices: Nexys 4 (Artix 7 100T)
-- Tool versions: ISE 14.7
-- Description: Register File for the MIPS processor
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

entity RegFile is
    Port ( 	ReadAddr1_Reg 	: in  STD_LOGIC_VECTOR (4 downto 0);
				ReadAddr2_Reg 	: in  STD_LOGIC_VECTOR (4 downto 0);
				ReadData1_Reg 	: out STD_LOGIC_VECTOR (31 downto 0);
				ReadData2_Reg 	: out STD_LOGIC_VECTOR (31 downto 0);				
				WriteAddr_Reg	: in  STD_LOGIC_VECTOR (4 downto 0); 
				WriteData_Reg 	: in STD_LOGIC_VECTOR (31 downto 0);
				RegWrite 		: in STD_LOGIC; 
				CLK 				: in  STD_LOGIC);
end RegFile;


architecture arch_RegFile of RegFile is

type reg_32 is array (0 to 31) of std_logic_vector (31 downto 0); -- array of 32 registers 

signal registers: reg_32 := (x"00000000", x"00000001", x"00000002", x"00000003", --register contents
								 x"00000004", x"00000005", x"00000006", x"00000007",
								 x"00000008", x"00000009", x"0000000A", x"0000000B",
								 x"0000000C", x"0000000D", x"0000000E", x"0000000F",
								 x"00000010", x"00000011", x"00000012", x"00000013",
								 x"00000014", x"00000015", x"00000016", x"00000017",
								 x"00000018", x"00000019", x"0000001A", x"0000001B",
								 x"0000001C", x"0000001D", x"0000001E", x"0000001F");
begin

-- read content of register (can be read anytime)
ReadData1_Reg <= registers(conv_integer(ReadAddr1_Reg));
ReadData2_Reg <= registers(conv_integer(ReadAddr2_Reg));

process(CLK)
begin

if (CLK'event and CLK='1') then	
	if RegWrite = '1' then 
		registers(conv_integer(WriteAddr_Reg)) <= WriteData_Reg; --write into register
	end if;
end if;
end process;
end arch_RegFile;



