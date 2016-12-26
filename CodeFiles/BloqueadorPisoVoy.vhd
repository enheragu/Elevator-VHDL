library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BoqueadorPisoVoy is

	generic (
	numPisos: positive:=4
	);

    Port ( Motor : in  STD_LOGIC_VECTOR(1 downto 0);
           SensorVoy : in  STD_LOGIC_VECTOR (numPisos-1 downto 0);
           PisoVoy : out  STD_LOGIC_VECTOR(numPisos-1 downto 0)
	);

end BoqueadorPisoVoy;

architecture behavioral of BoqueadorPisoVoy is

signal boton: STD_LOGIC_VECTOR (PisoVoy'range) := (others=>'0');

begin

	process (SensorVoy)
	begin
		if (rising_edge(SensorVoy(0)) or rising_edge(SensorVoy(1)) or rising_edge(SensorVoy(2)) or rising_edge(SensorVoy(3))) and Motor = "00" then
			boton <= sensorVoy;
		else 
			boton <= boton;
		end if;	
	end process;

	PisoVoy <= boton;

end behavioral;