LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
 
ENTITY Comparador_tb IS
END Comparador_tb;
 
ARCHITECTURE behavior OF Comparador_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Comparador
    PORT(
         PisoVoy : IN  INTEGER;
			PisoEstoy : IN  INTEGER;
         ControlMotor : OUT STD_LOGIC_VECTOR(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PisoVoy : INTEGER;
	signal PisoEstoy : INTEGER;

 	--Outputs
   signal ControlMotor : STD_LOGIC_VECTOR(1 downto 0);
	
	type vtest is record 
			PisoVoy : INTEGER;
			PisoEstoy : INTEGER;
         ControlMotor : STD_LOGIC_VECTOR(1 downto 0);
	end record;
	
	type vtest_vector is array (natural range <>) of vtest;
 
   constant test: vtest_vector := ( 
				 (PisoVoy => 0, PisoEstoy => 0, ControlMotor => "00"),
				 (PisoVoy => 2, PisoEstoy => 0, ControlMotor => "01"),
				 (PisoVoy => 2, PisoEstoy => 2, ControlMotor => "00"),				 
				 (PisoVoy => 0, PisoEstoy => 2, ControlMotor => "10"),
				 (PisoVoy => 0, PisoEstoy => 0, ControlMotor => "00")		 
	);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Comparador PORT MAP (
          PisoVoy => PisoVoy,
          PisoEstoy => PisoEstoy,
			 ControlMotor => ControlMotor
        );

	tb: process
	
	begin
		for i in 0 to test'high loop
			PisoVoy <= test(i).PisoVoy;
			PisoEstoy <= test(i).PisoEstoy;
			wait for 20 ns;
			assert ControlMotor = test(i).ControlMotor
				report "salida incorrecta"
				severity failure;
		end loop;
		
		assert false
			report "simulacion finalizada. Test superado."
			severity failure;
				
	end process;

END;