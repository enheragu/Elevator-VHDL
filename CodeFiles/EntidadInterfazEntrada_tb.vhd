-------------------------------------------------------------------------------
-- Title : Entidad Interfaz Entrada (tb)
-- Project : Elevator-VHDL
-------------------------------------------------------------------------------
-- File : EntidadInterfazEntrada_tb.vhd
-- Author : AranchaCM
-- Created : 2017/01/09
-- Last modified : 2017/01/10
-------------------------------------------------------------------------------
-- Description :
-- Implements athe testbench of EntidadInterfazEntrada.vhd
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
  
ENTITY EntidadInterfazEntrada_tb IS
END EntidadInterfazEntrada_tb;
 
ARCHITECTURE behavior OF EntidadInterfazEntrada_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT EntidadInterfazEntrada
    PORT(
         SensorVoy : IN  std_logic_vector(3 downto 0);
         SensorEstoy : IN  std_logic_vector(3 downto 0);
			Motor : IN  std_logic_vector(1 downto 0);
         PisoVoy : OUT  std_logic_vector(3 downto 0);
         PisoEstoy : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal SensorVoy : std_logic_vector(3 downto 0) := (others => '0');
   signal SensorEstoy : std_logic_vector(3 downto 0) := (others => '0');
	signal Motor : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal PisoVoy : std_logic_vector(3 downto 0);
   signal PisoEstoy : std_logic_vector(3 downto 0);
   
	type vtest is record 
			SensorEstoy : std_logic_vector(3 downto 0);
			SensorVoy : std_logic_vector(3 downto 0);
			Motor : std_logic_vector (1 downto 0);
			PisoVoy : std_logic_vector(3 downto 0);
			PisoEstoy : std_logic_vector(3 downto 0);
	end record;
	
	type vtest_vector is array (natural range <>) of vtest;
 
   constant test: vtest_vector := (  
				 (Motor => "00", SensorVoy => "1000", PisoVoy => "1000", SensorEstoy => "0010", PisoEstoy => "0010"),
				 (Motor => "10", SensorVoy => "1000", PisoVoy => "1000", SensorEstoy => "0010", PisoEstoy => "0010"),
				 (Motor => "10", SensorVoy => "0010", PisoVoy => "1000", SensorEstoy => "0000", PisoEstoy => "0010"),
				 (Motor => "10", SensorVoy => "0100", PisoVoy => "1000", SensorEstoy => "0100", PisoEstoy => "0100"),
				 (Motor => "10", SensorVoy => "0100", PisoVoy => "1000", SensorEstoy => "1000", PisoEstoy => "1000"),
				 (Motor => "00", SensorVoy => "0010", PisoVoy => "0010", SensorEstoy => "0000", PisoEstoy => "1000")
	);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: InterfazEntrada PORT MAP (
          SensorVoy => SensorVoy,
          SensorEstoy => SensorEstoy,
			 Motor => Motor,
          PisoVoy => PisoVoy,
          PisoEstoy => PisoEstoy
        );

  
 

   -- Stimulus process
   stim_proc: process
   begin		
		
		for i in 0 to test'high loop
			Motor <= test(i).Motor;
			SensorVoy <= test(i).SensorVoy;
			SensorEstoy <= test(i).SensorEstoy;
			wait for 20 ns;
			assert (PisoVoy = test(i).PisoVoy and PisoEstoy = test(i).PisoEstoy)
				report "salida incorrecta"
				severity failure;
		end loop;
		
      assert false
		report "Fin de la simulación. Test superado."
		severity failure;
   end process;

END;