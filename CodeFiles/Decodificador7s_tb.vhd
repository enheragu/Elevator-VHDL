LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Decodificador_tb IS
END Decodificador_tb;
 
ARCHITECTURE behavior OF Decodificador_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT Decodificador
    PORT(
         PisoVoy : IN  std_logic_vector(3 downto 0);
         PisoVoy7s : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
   --Inputs
   signal PisoVoy : std_logic_vector(3 downto 0) := (others => '0');
 	--Outputs
   signal PisoVoy7s : std_logic_vector(6 downto 0);
	--estructura tipo tecord
	TYPE vtest is record
      PisoVoy   : std_logic_vector(3 DOWNTO 0);
      PisoVoy7s : std_logic_vector(6 DOWNTO 0);
   END RECORD;
	
   TYPE vtest_vector IS ARRAY (natural RANGE <>) OF vtest;
	
	CONSTANT test: vtest_vector := (
		(PisoVoy => "0001", PisoVoy7s => "1001111"), -- Piso 1
		(PisoVoy => "0010", PisoVoy7s => "0010010"), -- Piso 2
		(PisoVoy => "0100", PisoVoy7s => "0000110"), -- Piso 3
		(PisoVoy => "1000", PisoVoy7s => "1001100"), -- Piso 4
		(PisoVoy => "0000", PisoVoy7s => "0110000"), -- Test de error
		(PisoVoy => "0011", PisoVoy7s => "0110000"),
		(PisoVoy => "0101", PisoVoy7s => "0110000"),
		(PisoVoy => "0110", PisoVoy7s => "0110000"),
		(PisoVoy => "0111", PisoVoy7s => "0110000"),
		(PisoVoy => "1001", PisoVoy7s => "0110000"),
		(PisoVoy => "1010", PisoVoy7s => "0110000"),
		(PisoVoy => "1011", PisoVoy7s => "0110000"),
		(PisoVoy => "1100", PisoVoy7s => "0110000"),
		(PisoVoy => "1101", PisoVoy7s => "0110000"),
		(PisoVoy => "1110", PisoVoy7s => "0110000"),
		(PisoVoy => "1111", PisoVoy7s => "0110000")
		 );

BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: Decodificador PORT MAP (
          PisoVoy => PisoVoy,
          PisoVoy7s => PisoVoy7s
        );

	tb: PROCESS 
		BEGIN
			FOR i IN 0 TO test'HIGH LOOP  
				PisoVoy <= test(i).PisoVoy;
				WAIT FOR 20 ns;
					ASSERT PisoVoy7s = test(i).PisoVoy7s
						REPORT "Salida incorrecta." 
						SEVERITY FAILURE;
			END LOOP;
		
			ASSERT false
			REPORT "Simulacion finalizada. Test superado." 
			SEVERITY FAILURE;
		END PROCESS;


END;
