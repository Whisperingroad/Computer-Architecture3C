--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:38:26 10/31/2014
-- Design Name:   
-- Module Name:   C:/Users/User/Documents/GitHub/Computer-Architecure-Lab3/Lab3/regfile_testbench.vhd
-- Project Name:  Lab3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RegFile
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY regfile_testbench IS
END regfile_testbench;
 
ARCHITECTURE behavior OF regfile_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegFile
    PORT(
         ReadAddr1_Reg : IN  std_logic_vector(4 downto 0);
         ReadAddr2_Reg : IN  std_logic_vector(4 downto 0);
         ReadData1_Reg : OUT  std_logic_vector(31 downto 0);
         ReadData2_Reg : OUT  std_logic_vector(31 downto 0);
         WriteAddr_Reg : IN  std_logic_vector(4 downto 0);
         WriteData_Reg : IN  std_logic_vector(31 downto 0);
         RegWrite : IN  std_logic;
         CLK : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal ReadAddr1_Reg : std_logic_vector(4 downto 0) := (others => '0');
   signal ReadAddr2_Reg : std_logic_vector(4 downto 0) := (others => '0');
   signal WriteAddr_Reg : std_logic_vector(4 downto 0) := (others => '0');
   signal WriteData_Reg : std_logic_vector(31 downto 0) := (others => '0');
   signal RegWrite : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal ReadData1_Reg : std_logic_vector(31 downto 0);
   signal ReadData2_Reg : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegFile PORT MAP (
          ReadAddr1_Reg => ReadAddr1_Reg,
          ReadAddr2_Reg => ReadAddr2_Reg,
          ReadData1_Reg => ReadData1_Reg,
          ReadData2_Reg => ReadData2_Reg,
          WriteAddr_Reg => WriteAddr_Reg,
          WriteData_Reg => WriteData_Reg,
          RegWrite => RegWrite,
          CLK => CLK
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
   
      wait for 100 ns;	
		ReadAddr1_Reg  <= "00000";
		ReadAddr1_Reg  <= "00010";
		WriteAddr_Reg	<= "00010";
		WriteData_Reg  <= x"01111111";
		RegWrite <= '0';
		
		wait for 100 ns;	
		ReadAddr1_Reg  <= "00000";
		ReadAddr1_Reg  <= "00010";
		WriteAddr_Reg	<= "00010";
		WriteData_Reg  <= x"01111111";
		RegWrite <= '1';
		
     -- wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
