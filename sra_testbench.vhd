--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:52:52 11/10/2014
-- Design Name:   
-- Module Name:   C:/Users/Sebastian/Documents/GitHub/Computer-Architecture3C/Lab3/sra_testbench.vhd
-- Project Name:  Lab3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sra_shifter
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
 
ENTITY sra_testbench IS
END sra_testbench;
 
ARCHITECTURE behavior OF sra_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sra_shifter
    PORT(
         Source : IN  std_logic_vector(31 downto 0);
         Command : IN  std_logic_vector(1 downto 0);
         Shift_number : IN  std_logic_vector(4 downto 0);
         sra_output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Source : std_logic_vector(31 downto 0) := (others => '0');
   signal Command : std_logic_vector(1 downto 0) := (others => '0');
   signal Shift_number : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal sra_output : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sra_shifter PORT MAP (
          Source => Source,
          Command => Command,
          Shift_number => Shift_number,
          sra_output => sra_output
        );

   -- Clock process definitions
--   <clock>_process :process
 --  begin
--		<clock> <= '0';
		--wait for <clock>_period/2;
	--	<clock> <= '1';
		--wait for <clock>_period/2;
  -- end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
     wait for 100 ns;
		Source <= x"80000000";
		Command <= "10";
		Shift_number <= "00001";
		
		wait for 100 ns;
		Source <= x"80000000";
		Command <= "10";
		Shift_number <= "00001"; --shift 1 position

		wait for 100 ns;
		Source <= x"80000000";
		Command <= "10";
		Shift_number <= "00010";	--shift 2 position
		
		wait for 100 ns;
		Source <= x"80000000";
		Command <= "10";
		Shift_number <= "00100"; -- shift 4 positions

		wait for 100 ns;
		Source <= x"80000000";
		Command <= "10";
		Shift_number <= "01000"; --shift 8 positions
		
		wait for 100 ns;
		Source <= x"80000000";
		Command <= "10";
		Shift_number <= "01111"; --shift 15 positions

		wait for 100 ns;
		Source <= x"80000000";
		Command <= "10";
		Shift_number <= "11111"; --shift 32 positions

	

--      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
