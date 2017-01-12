 -------------------------------------------------------------------------------
 -- Title : Piso Actual
 -- Project : Elevator-VHDL
 -------------------------------------------------------------------------------
 -- File : PisoActual.vhd
 -- Author : EnriqueHE
 -- Created : 2016/12/26
 -- Last modified : 2017/01/11
 -------------------------------------------------------------------------------
 -- Description :
 -- Implements the filter of the endstops
 -------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PisoActual is
    Port ( SensorEstoy : in  STD_LOGIC_VECTOR (3 downto 0);
			  CLK: in STD_LOGIC;
           PisoEstoy : out  STD_LOGIC_VECTOR (3 downto 0)
			 );
end entity PisoActual;

architecture Behavioral of PisoActual is

signal aux1: STD_LOGIC_VECTOR (SensorEstoy'range):="0000";

begin
	process (SensorEstoy,CLK)
	begin
		IF rising_edge(CLK) and (sensorEstoy="0001" or 
		   sensorEstoy="0010" or 
		   sensorEstoy="0100" or 
		   sensorEstoy="1000") then
			aux1 <= SensorEstoy;
		end if;
	
	end process;

	PisoEstoy <= aux1;
		 
end Behavioral;

