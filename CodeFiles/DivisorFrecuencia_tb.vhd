LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY DivisorFrecuencia_tb IS
END DivisorFrecuencia_tb;
 
ARCHITECTURE behavior OF DivisorFrecuencia_tb IS 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT DivisorFrecuencia PORT(
			  PisoVoy7s : in  STD_LOGIC; -- reloj entrada
			  reset     : in  STD_LOGIC;
			  PisoVoy   : out STD_LOGIC
        );
    END COMPONENT;
	-- SEÑALES
	-- Entradas
    signal PisoVoy7s : std_logic := '0'; -- asignamos valor inicial
    signal reset   : std_logic := '0';
    -- Salidas
    signal PisoVoy  : std_logic;
	 
   -- appropriate port name 
   constant clock_period : time := 20 ns; -- frecuencia reloj entrada
	
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: DivisorFrecuencia PORT MAP (
			PisoVoy7s => PisoVoy7s,
			reset   => reset,
			PisoVoy  => PisoVoy
        );
		  
   -- Clock process definitions AQUI ESTABLECEMOS EL RELOJ DE ENTRADA
   clock_process :process
   begin
		PisoVoy7s <= '0';
		wait for clock_period/2;
		PisoVoy7s <= '1';
		wait for clock_period/2;
   end process;
	
   -- Stimulus process
   stim_proc: process
   begin		
		  reset <= '1'; -- Condiciones iniciales.
        wait for 500 ns;
        reset <= '0'; -- ¡A trabajar!
        wait; 
   end process;

END;
