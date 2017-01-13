 -------------------------------------------------------------------------------
 -- Title : Decodificador LED
 -- Project : Elevator-VHDL
 -------------------------------------------------------------------------------
 -- File : DecodificadorLED.vhd
 -- Author : Arancha CM, AlbertoBB, EnriqueHE
 -- Created : 2017/01/12
 -- Last modified : 2017/01/12
 -------------------------------------------------------------------------------
 -- Description :
 -- 
 -------------------------------------------------------------------------------
 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DecodificadorLED is
	PORT(
	  MemPisoVoy1, MemPisoVoy2 :  in  STD_LOGIC_VECTOR(3 downto 0);
	  CLK: in STD_LOGIC;
	  LED: OUT STD_LOGIC_VECTOR (7 downto 0)
	);
end DecodificadorLED;

architecture Behavioral of DecodificadorLED is

begin
	process (CLK)
	begin
	IF rising_edge(CLK) THEN
		case MemPisoVoy1 is
			when "0001" => LED(0)<='1'; LED(1)<='0'; LED(2)<='0'; LED(3)<='0';
			when "0010" => LED(0)<='0'; LED(1)<='1'; LED(2)<='0'; LED(3)<='0';
			when "0100" => LED(0)<='0'; LED(1)<='0'; LED(2)<='1'; LED(3)<='0';
			when "1000" => LED(0)<='0'; LED(1)<='0'; LED(2)<='0'; LED(3)<='1';
			when others => LED(0)<='0'; LED(1)<='0'; LED(2)<='0'; LED(3)<='0';
		end case;
		
		case MemPisoVoy2 is
			when "0001" => LED(4)<='1'; LED(5)<='0'; LED(6)<='0'; LED(7)<='0';
			when "0010" => LED(4)<='0'; LED(5)<='1'; LED(6)<='0'; LED(7)<='0';
			when "0100" => LED(4)<='0'; LED(5)<='0'; LED(6)<='1'; LED(7)<='0';
			when "1000" => LED(4)<='0'; LED(5)<='0'; LED(6)<='0'; LED(7)<='1';
			when others => LED(4)<='0'; LED(5)<='0'; LED(6)<='0'; LED(7)<='0';	
		end case;
	end if;
	end process;
end Behavioral;

