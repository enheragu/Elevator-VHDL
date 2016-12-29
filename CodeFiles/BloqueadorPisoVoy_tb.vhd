LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY BloqueadorPisoVoy_tb IS
END BloqueadorPisoVoy_tb;
 
ARCHITECTURE behavior OF BloqueadorPisoVoy_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT BoqueadorPisoVoy
    PORT(
         Motor : IN  std_logic_vector(1 downto 0);
         SensorVoy : IN  std_logic_vector(3 downto 0);
         PisoVoy : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal Motor : std_logic_vector(1 downto 0) := (others => '0');
   signal SensorVoy : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal PisoVoy : std_logic_vector(3 downto 0);
 	
	type vtest is record
				Motor : std_logic_vector(1 downto 0);
				SensorVoy : std_logic_vector(3 downto 0);
				PisoVoy : std_logic_vector(3 downto 0);
	end record;
	
	type vtest_vector is array (natural range <>) of vtest;
	
	constant test: vtest_vector := (
												(Motor => "00", SensorVoy => "0000", PisoVoy => "0000"),
												(Motor => "00", SensorVoy => "0001", PisoVoy => "0001"),
												(Motor => "01", SensorVoy => "0001", PisoVoy => "0001"),
												(Motor => "01", SensorVoy => "1000", PisoVoy => "0001"),
												(Motor => "01", SensorVoy => "0100", PisoVoy => "0001"),
												(Motor => "00", SensorVoy => "0100", PisoVoy => "0001"),
												(Motor => "00", SensorVoy => "1000", PisoVoy => "1000"),
												(Motor => "10", SensorVoy => "1000", PisoVoy => "1000"),
												(Motor => "10", SensorVoy => "0010", PisoVoy => "1000"),
												(Motor => "10", SensorVoy => "0100", PisoVoy => "1000"),
												(Motor => "00", SensorVoy => "0100", PisoVoy => "1000"),
												(Motor => "00", SensorVoy => "0010", PisoVoy => "0010")
												);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BoqueadorPisoVoy PORT MAP (
          Motor => Motor,
          SensorVoy => SensorVoy,
          PisoVoy => PisoVoy
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
		
		for i in 0 to test'high loop
											Motor <= test(i).Motor;
											SensorVoy <= test(i).SensorVoy;
											wait for 20 ns;
											assert PisoVoy = test(i).PisoVoy
												report "salida incorrecta"
												severity failure;
											end loop;
		
      assert false
			report "fin de la simulaci�n"
			severity failure;
      -- insert stimulus here 
   end process;
END;