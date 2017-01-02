LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
 
ENTITY PisoActual_tb IS
END PisoActual_tb;
 
ARCHITECTURE behavior OF PisoActual_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PisoActual
    PORT(
         SensorEstoy : IN  std_logic_vector(3 downto 0);
         PisoEstoy : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal SensorEstoy : std_logic_vector(3 downto 0);

 	--Outputs
   signal PisoEstoy : std_logic_vector(6 downto 0);
	
	type vtest is record 
			SensorEstoy : std_logic_vector(3 downto 0);
			PisoEstoy : std_logic_vector(3 downto 0);
	end record;
	
	type vtest_vector is array (natural range <>) of vtest;
 
   constant test: vtest_vector := ( 
				 (sensorEstoy => "0000", pisoEstoy => "0000"), 
				 (sensorEstoy => "0001", pisoEstoy => "0001"),
				 (sensorEstoy => "0000", pisoEstoy => "0001"),
				 (sensorEstoy => "0010", pisoEstoy => "0010"),
				 (sensorEstoy => "0000", pisoEstoy => "0010"),
				 (sensorEstoy => "0100", pisoEstoy => "0100"),
				 (sensorEstoy => "0000", pisoEstoy => "0100"),
				 (sensorEstoy => "1000", pisoEstoy => "1000")		 
	);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PisoActual PORT MAP (
          SensorEstoy => SensorEstoy,
          PisoEstoy => PisoEstoy
        );

	tb: process
	
	begin
		for i in 0 to test'high loop
			SensorEstoy <= test(i).SensorEstoy;
			wait for 20 ns;
			assert PisoEstoy = test(i).PisoEstoy
				report "salida incorrecta"
				severity failure;
		end loop;
		
		assert false
			report "simulacion finalizada. Test superado."
			severity failure;
				
	end process;

END;
