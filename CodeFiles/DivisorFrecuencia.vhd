library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DivisorFrecuencia is
	Port(
	     PisoVoy7s : in  STD_LOGIC; -- reloj entrada
        reset     : in  STD_LOGIC;
        PisoVoy    : out STD_LOGIC
	);
end DivisorFrecuencia;

architecture Behavioral of DivisorFrecuencia is
		signal temporal: STD_LOGIC; --temporal: es el reloj de SALIDA
		signal contador: integer range 0 to 124999 := 0; --escala: ESCALA/2
begin
		divisor_frecuencia: process (reset, PisoVoy7s) 
		begin
			if (reset = '1') then -- reset: ponemos todo a cero
					temporal <= '0';
					contador <= 0;
			elsif rising_edge(PisoVoy7s) then
					if (contador = 124999) then
						temporal <= NOT(temporal); -- realizamos cambio
						contador <= 0;
					else
						contador <= contador+1;
					end if;
        end if;
      end process;  
PisoVoy <= temporal; -- SABEMOS QUE TEMPORAL ES LA SALIDA
end Behavioral;

