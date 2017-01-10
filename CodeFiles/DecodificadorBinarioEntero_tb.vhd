 -------------------------------------------------------------------------------
 -- Title : Decodificador Binario Entero (tb)
 -- Project : Elevator-VHDL
 -------------------------------------------------------------------------------
 -- File : DecodificadorBinarioEntero_tb.vhd
 -- Author : Arancha CM, AlbertoBB, EnriqueHE
 -- Created : 2016/12/26
 -- Last modified : 2016/12/26
 -------------------------------------------------------------------------------
 -- Description :
 -- Implements athe testbench of DecodificadorBinarioEntero.vhd
 -------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY DecodificadorBinarioEntero_tb IS
END DecodificadorBinarioEntero_tb;
 
ARCHITECTURE behavior OF DecodificadorBinarioEntero_tb IS 
 
    COMPONENT DecodificadorBinarioEntero
    PORT(
         EntradaBinaria : IN  std_logic_vector(3 downto 0);
         SalidaEntera : OUT  integer
        );
    END COMPONENT;
    

   --Inputs
   signal EntradaBinaria : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal SalidaEntera : integer;
	
	type vtest is record
						EntradaBinaria : std_logic_vector(3 downto 0);
						SalidaEntera : integer;
	end record;
	
	type vtest_vector is array (natural range <>) of vtest;
	
	constant test: vtest_vector := (
				 (EntradaBinaria => "0000", SalidaEntera => 0),
				 (EntradaBinaria => "0001", SalidaEntera => 1),
				 (EntradaBinaria => "0000", SalidaEntera => 0),
				 (EntradaBinaria => "0010", SalidaEntera => 2),
				 (EntradaBinaria => "0000", SalidaEntera => 0),
				 (EntradaBinaria => "0100", SalidaEntera => 3),
				 (EntradaBinaria => "0000", SalidaEntera => 0),
				 (EntradaBinaria => "1000", SalidaEntera => 4)
	);
		
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DecodificadorBinarioEntero PORT MAP (
          EntradaBinaria => EntradaBinaria,
          SalidaEntera => SalidaEntera
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      for i in 0 to test'high loop
				EntradaBinaria <= test(i).EntradaBinaria;
				wait for 20 ns;
				assert SalidaEntera = test(i).SalidaEntera
					report "salida incorrecta"
					severity failure;
		end loop;
		
		assert false
			report "simulacion finalizada, test superado"
			severity failure;

   end process;

END;