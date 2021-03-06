 -------------------------------------------------------------------------------
 -- Title : Decodificador7s
 -- Project : Elevator-VHDL
 -------------------------------------------------------------------------------
 -- File : PisoActual.vhd
 -- Author : AlbertoBB
 -- Created : 2016/12/18
 -- Last modified : 2017/01/11
 -------------------------------------------------------------------------------
 -- Description :
 -- Implementation for seven-segment display
 -------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_arith.ALL; 
USE ieee.std_logic_unsigned.ALL;

entity Decodificador7s is
    Port ( EntradaPisoBinaria   : in  STD_LOGIC_vector(3 DOWNTO 0);
           SalidaPiso7s : out  STD_LOGIC_vector(6 DOWNTO 0)
		  );
end Decodificador7s;

architecture Behavioral of Decodificador7s is

begin
	WITH EntradaPisoBinaria SELECT
		SalidaPiso7s <= "1001111" WHEN "0001", -- Lectura Piso 1
				"0010010" WHEN "0010", -- Lectura Piso 2
				"0000110" WHEN "0100", -- Lectura Piso 3
            "1001100" WHEN "1000", -- Lectura Piso 4
            "0110000" WHEN others; -- Error 
end Behavioral;

