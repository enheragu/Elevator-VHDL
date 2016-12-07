LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
 
ENTITY PisoActual_tb IS
END PisoActual_tb;
 
ARCHITECTURE behavior OF PisoActual_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PisoActual
    PORT(
         sensorEstoy : IN  std_logic_vector(3 downto 0);
         pisoEstoy : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal sensorEstoy : std_logic_vector(3 downto 0);

 	--Outputs
   signal pisoEstoy : std_logic_vector(6 downto 0);
	
	type vtest is record 
			sensorEstoy : std_logic_vector(3 downto 0);
			pisoEstoy : std_logic_vector(3 downto 0);
	end record;
	
	type vtest_vector is array (natural range <>) of vtest;
 
   test: vtest_vector := ( 
				 (sensorEstoy => "0000", pisoEstoy => "0000"), 
				 (sensorEstoy => "0001", pisoEstoy => "0001"),
				 (sensorEstoy => "0010", pisoEstoy => "0010"),
				 (sensorEstoy => "0100", pisoEstoy => "0100"),
				 (sensorEstoy => "1000", pisoEstoy => "1000")		 
	);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PisoActual PORT MAP (
          sensorEstoy => sensorEstoy,
          pisoEstoy => pisoEstoy
        );

	tb: process
	
	begin
		for i in 0 to test'high loop
			sensorEstoy <= test(i).sensorEstoy;
			wait for 20 ns;
			if (test(i).sensorEstoy /= "0000") then
				test(i).pisoEstoy <= test(i).sensorEstoy;
			assert pisoEstoy = test(i).pisoEstoy
				report "salida incorrecta"
				severity failure;
		end loop;
		
		assert false
			report "simulacion finalizada. Test superado."
			severity failure;
				
	end process;

END;
