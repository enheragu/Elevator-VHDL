LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Decodificador_tb IS
END Decodificador_tb;
 
ARCHITECTURE behavior OF Decodificador_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT Decodificador
    PORT(
         EntradaPisoBinario : IN  std_logic_vector(3 downto 0);
         SalidaPiso7s : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
   --Inputs
   signal EntradaPisoBinario : std_logic_vector(3 downto 0) := (others => '0');
 	--Outputs
   signal SalidaPiso7s : std_logic_vector(6 downto 0);
	--estructura tipo tecord
	TYPE vtest is record
      EntradaPisoBinario   : std_logic_vector(3 DOWNTO 0);
      SalidaPiso7s : std_logic_vector(6 DOWNTO 0);
   END RECORD;
	
   TYPE vtest_vector IS ARRAY (natural RANGE <>) OF vtest;
	
	CONSTANT test: vtest_vector := (
		(EntradaPisoBinario => "0001", SalidaPiso7s => "1001111"), -- Piso 1
		(EntradaPisoBinario => "0010", SalidaPiso7s => "0010010"), -- Piso 2
		(EntradaPisoBinario => "0100", SalidaPiso7s => "0000110"), -- Piso 3
		(EntradaPisoBinario => "1000", SalidaPiso7s => "1001100"), -- Piso 4
		(EntradaPisoBinario => "0000", SalidaPiso7s => "0110000"), -- Test de error
		(EntradaPisoBinario => "0011", SalidaPiso7s => "0110000"),
		(EntradaPisoBinario => "0101", SalidaPiso7s => "0110000"),
		(EntradaPisoBinario => "0110", SalidaPiso7s => "0110000"),
		(EntradaPisoBinario => "0111", SalidaPiso7s => "0110000"),
		(EntradaPisoBinario => "1001", SalidaPiso7s => "0110000"),
		(EntradaPisoBinario => "1010", SalidaPiso7s => "0110000"),
		(EntradaPisoBinario => "1011", SalidaPiso7s => "0110000"),
		(EntradaPisoBinario => "1100", SalidaPiso7s => "0110000"),
		(EntradaPisoBinario => "1101", SalidaPiso7s => "0110000"),
		(EntradaPisoBinario => "1110", SalidaPiso7s => "0110000"),
		(EntradaPisoBinario => "1111", SalidaPiso7s => "0110000")
		 );

BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: Decodificador PORT MAP (
          EntradaPisoBinario => EntradaPisoBinario,
          SalidaPiso7s => SalidaPiso7s
        );

	tb: PROCESS 
		BEGIN
			FOR i IN 0 TO test'HIGH LOOP  
				EntradaPisoBinario <= test(i).EntradaPisoBinario;
				WAIT FOR 20 ns;
					ASSERT SalidaPiso7s = test(i).SalidaPiso7s
						REPORT "Salida incorrecta." 
						SEVERITY FAILURE;
			END LOOP;
		
			ASSERT false
			REPORT "Simulacion finalizada. Test superado." 
			SEVERITY FAILURE;
		END PROCESS;


END;
