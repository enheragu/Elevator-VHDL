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
		for i in 0 to (numPisos-1) loop
			if ((SensorVoy(i)'event and SensorVoy(i) = '1' and SensorVoy(i)'last_value = '0') and Motor = "00") then
				boton <= SensorVoy;
			else 
				boton <= boton;
			end if;	
		end loop;
	end process;

	PisoVoy <= boton;

end behavioral;
