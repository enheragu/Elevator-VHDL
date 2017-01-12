 -------------------------------------------------------------------------------
 -- Title : Comparador
 -- Project : Elevator-VHDL
 -------------------------------------------------------------------------------
 -- File : Comparador.vhd
 -- Author : Arancha CM, AlbertoBB, EnriqueHE
 -- Created : 2016/12/26
 -- Last modified : 2017/01/03
 -------------------------------------------------------------------------------
 -- Description :
 -- Implements an integer comparator. Has 2 inputs (integer values) and a
 -- two bit output (engine operation)
 -------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Comparador is
    Port ( 	
			PisoVoy : in  INTEGER;
			PisoEstoy : in  INTEGER;
			CLK: in STD_LOGIC;
         ControlMotor : out STD_LOGIC_VECTOR(1 downto 0)
			  ); 
end Comparador; 

architecture Behavioral of Comparador is

begin
	process (PisoEstoy, PisoVoy, CLK)
	begin
	IF rising_edge(CLK) THEN
		IF PisoVoy = 0 or PisoEstoy = 0 THEN
			ControlMotor <= "00"; -- engine stopped
			
		ELSIF PisoVoy = PisoEstoy THEN
			ControlMotor <= "00"; -- engine stopped
			
		ELSIF PisoVoy > PisoEstoy THEN
			ControlMotor <= "01"; -- rising
			
		ELSE ControlMotor <= "10"; -- descending
		end if;
	END IF;
	END process;
end Behavioral;