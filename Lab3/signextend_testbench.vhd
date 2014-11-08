--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:49:08 10/29/2014
-- Design Name:   
-- Module Name:   C:/Users/Sebastian/Documents/GitHub/Computer-Architecure-Lab3/Lab3/signextend_testbench.vhd
-- Project Name:  Lab3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Sign_Extend
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
 
ENTITY signextend_testbench IS
END signextend_testbench;
 
ARCHITECTURE behavior OF signextend_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Sign_Extend
    PORT(
         signExtendInput : IN  std_logic_vector(15 downto 0);
         signExtendOutput : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal signExtendInput : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal signExtendOutput : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Sign_Extend PORT MAP (
          signExtendInput => signExtendInput,
          signExtendOutput => signExtendOutput
        );

   -- Clock process definitions
--   <clock>_process :process
  -- begin
	--	<clock> <= '0';
		--wait for <clock>_period/2;
		--<clock> <= '1';
		--wait for <clock>_period/2;
   --end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		--wait for <clock>_period*10;
		signExtendInput <= x"0000";
		
		wait for 100 ns;
		signExtendInput <= x"000F";
		
		wait for 100 ns;
		signExtendInput <= x"F000";
		
		wait for 100 ns;
		signExtendInput <= x"FFFF";
		
		
		
		
		

      -- insert stimulus here 

      wait;
   end process;

END;
