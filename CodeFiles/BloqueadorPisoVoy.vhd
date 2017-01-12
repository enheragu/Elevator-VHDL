-------------------------------------------------------------------------------
-- Title : Bloqueador Piso Voy
-- Project : Elevator-VHDL
-------------------------------------------------------------------------------
-- File : BloqueadorPisoVoy.vhd
-- Author : AranchaCM
-- Created : 2016/12/26
-- Last modified : 2017/01/11
-------------------------------------------------------------------------------
-- Description :
-- Implements the filter of the buttons
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BoqueadorPisoVoy is

	generic (
	numPisos: positive:=4
	);

    Port ( Motor : in  STD_LOGIC_VECTOR(1 downto 0);
           SensorVoy : in  STD_LOGIC_VECTOR (numPisos-1 downto 0);
			  CLK: in STD_LOGIC;
           PisoVoy : out  STD_LOGIC_VECTOR(numPisos-1 downto 0)
	);

end BoqueadorPisoVoy;

architecture behavioral of BoqueadorPisoVoy is

signal boton: STD_LOGIC_VECTOR (PisoVoy'range):= "0000";

begin

	process (SensorVoy, Motor, CLK)	
	begin
		if rising_edge(CLK) and Motor = "00" then
			if SensorVoy = "0001" or
				SensorVoy = "0010" or 
				SensorVoy = "0100" or 
				SensorVoy = "1000" then
				boton <= SensorVoy;
			end if;
		end if;
	end process;

	PisoVoy <= boton;

end behavioral;