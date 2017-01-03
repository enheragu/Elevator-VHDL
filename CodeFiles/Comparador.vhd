library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Comparador is
    Port ( 	
			PisoVoy : in  INTEGER;
			PisoEstoy : in  INTEGER;
         ControlMotor : out STD_LOGIC_VECTOR(1 downto 0)
			  ); 
end Comparador; 

architecture Behavioral of Comparador is

begin
	process (PisoEstoy, PisoVoy)
	begin
		IF PisoVoy = PisoEstoy THEN
			ControlMotor <= "00";
			
		ELSIF PisoVoy > PisoEstoy THEN
			ControlMotor <= "01";
			
		ELSE ControlMotor <= "10";
		end if;
	END process;
end Behavioral;