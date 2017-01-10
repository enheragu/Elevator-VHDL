 -------------------------------------------------------------------------------
 -- Title : Decodificador Binario Entero
 -- Project : Elevator-VHDL
 -------------------------------------------------------------------------------
 -- File : DecodificadorBinarioEntero.vhd
 -- Author : Arancha CM, AlbertoBB, EnriqueHE
 -- Created : 2016/12/26
 -- Last modified : 2016/12/31
 -------------------------------------------------------------------------------
 -- Description :
 -- Implements a dcimal binary decoder
 -------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DecodificadorBinarioEntero is
    Port ( EntradaBinaria : in  STD_LOGIC_VECTOR(3 downto 0);
           SalidaEntera : out  INTEGER);
end DecodificadorBinarioEntero;

architecture Behavioral of DecodificadorBinarioEntero is

begin
	with EntradaBinaria select 
		SalidaEntera <= 1 when "0001",
							 2 when "0010",
							 3 when "0100",
							 4 when "1000",
							 0 when others;

end Behavioral;

