library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PisoActual is
    Port ( SensorEstoy : in  STD_LOGIC_VECTOR (3 downto 0);
           PisoEstoy : out  STD_LOGIC_VECTOR (3 downto 0)
			 );
end entity PisoActual;

architecture Dataflow of PisoActual is

signal aux1: STD_LOGIC_VECTOR (SensorEstoy'range) := (others => '0');

begin
	process (SensorEstoy)
	begin
		IF (sensorEstoy /= "0000") then
		aux1 <= sensorEstoy;
		end if;
	end process;

	with sensorEstoy select
		pisoEstoy <= aux1 when "0000",
			     sensorEstoy when "0001",
			     sensorEstoy when "0010",
			     sensorEstoy when "0100",
			     sensorEstoy when "1000",
			     "1111" when others;
		 
end architecture Dataflow;

