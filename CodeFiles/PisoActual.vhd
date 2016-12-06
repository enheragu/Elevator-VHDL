library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PisoActual is
    Port ( sensorEstoy : in  STD_LOGIC_VECTOR (3 downto 0);
           pisoEstoy : out  STD_LOGIC_VECTOR (3 downto 0)
			 );
end entity PisoActual;

architecture Dataflow of PisoActual is

signal aux1: STD_LOGIC_VECTOR (sensorEstoy'range);

begin

IF (sensorEstoy /= "0000") then
	aux1 <= sensorEstoy;

with sensorEstoy select
		pisoEstoy <= aux1 when "0000",
				 sensorEstoy when "0001",
				 sensorEstoy when "0010",
				 sensorEstoy when "0100",
				 sensorEstoy when "1000",
				 "1111" when others;
		 
end architecture Dataflow;

