-------------------------------------------------------------------------------
-- Title : DecodificadorLED (tb)
-- Project : Elevator-VHDL
-------------------------------------------------------------------------------
-- File : DecodificadorLED_tb.vhd
-- Author : AranchaCM, EnriqueHE, AlbertoBB
-- Created : 2017/01/012
-- Last modified : 2017/01/13
-------------------------------------------------------------------------------
-- Description :
-- Implements athe testbench of DecodificadorLED.vhd
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY DecodificadorLED_tb IS
END DecodificadorLED_tb;
 
ARCHITECTURE behavior OF DecodificadorLED_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DecodificadorLED
    PORT(
         MemPisoVoy1 : IN  std_logic_vector(3 downto 0);
         MemPisoVoy2 : IN  std_logic_vector(3 downto 0);
         CLK : IN  std_logic;
         LED : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal MemPisoVoy1 : std_logic_vector(3 downto 0) := (others => '0');
   signal MemPisoVoy2 : std_logic_vector(3 downto 0) := (others => '0');
   signal CLK : std_logic := '0';

 	--Outputs
   signal LED : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
	
	type vtest is record 
		  MemPisoVoy1 : std_logic_vector(3 downto 0);
		  MemPisoVoy2 : std_logic_vector(3 downto 0);
		  LED : std_logic_vector(7 downto 0);
	end record;
	
	type vtest_vector is array (natural range <>) of vtest;
 
   constant test: vtest_vector := ( 
			(MemPisoVoy1=> "0001", MemPisoVoy2 => "0010", LED => "00100001"),
			(MemPisoVoy1=> "0010", MemPisoVoy2 => "0000", LED => "00000010"),
			(MemPisoVoy1=> "0000", MemPisoVoy2 => "0000", LED => "00000000")
	 
	);
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DecodificadorLED PORT MAP (
          MemPisoVoy1 => MemPisoVoy1,
          MemPisoVoy2 => MemPisoVoy2,
          CLK => CLK,
          LED => LED
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
	  for i in 0 to test'high loop
			MemPisoVoy1 <= test(i).MemPisoVoy1;
			MemPisoVoy2 <= test(i).MemPisoVoy2;
			
			wait for 200 ns;
			assert LED = test(i).LED
				report "salida incorrecta"
				severity failure;
		end loop;
		
		assert false
			report "simulacion finalizada. Test superado."
			severity failure;

      wait;
   end process;

END; 