library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_arith.ALL; 
USE ieee.std_logic_unsigned.ALL;

entity Decodificador is
    Port ( PisoVoy   : in  STD_LOGIC_vector(3 DOWNTO 0);
           PisoVoy7s : out  STD_LOGIC_vector(6 DOWNTO 0)
			  );
end Decodificador;

architecture Behavioral of Decodificador is

begin
	WITH PisoVoy SELECT
		PisoVoy7s <=  "1001111" WHEN "0001", -- Lectura Piso 1
					     "0010010" WHEN "0010", -- Lectura Piso 2
					     "0000110" WHEN "0100", -- Lectura Piso 3
			           "1001100" WHEN "1000", -- Lectura Piso 4
			           "0110000" WHEN others; -- Error cuando la lectura de los sensores no hace referencia a nigun piso
 
end Behavioral;

