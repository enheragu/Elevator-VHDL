 -------------------------------------------------------------------------------
 -- Title : Decodificador LED
 -- Project : Elevator-VHDL
 -------------------------------------------------------------------------------
 -- File : DecodificadorLED.vhd
 -- Author : Arancha CM, AlbertoBB, EnriqueHE
 -- Created : 2016/12/26
 -- Last modified : 2016/12/31
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
	  LED0,LED1,LED2,LED3,LED4,LED5,LED6,LED7 : OUT STD_LOGIC
	);
end DecodificadorLED;

architecture Behavioral of DecodificadorLED is

begin
	process (CLK)
	begin
	IF rising_edge(CLK) THEN
		case MemPisoVoy1 is
			when "0001" => LED0<='1'; LED1<='0'; LED2<='0'; LED3<='0';
			when "0010" => LED0<='0'; LED1<='1'; LED2<='0'; LED3<='0';
			when "0100" => LED0<='0'; LED1<='0'; LED2<='1'; LED3<='0';
			when "1000" => LED0<='0'; LED1<='0'; LED2<='0'; LED3<='1';
			when others => LED0<='0'; LED1<='0'; LED2<='0'; LED3<='0';
		end case;
		
		case MemPisoVoy2 is
			when "0001" => LED4<='1'; LED5<='0'; LED6<='0'; LED7<='0';
			when "0010" => LED4<='0'; LED5<='1'; LED6<='0'; LED7<='0';
			when "0100" => LED4<='0'; LED5<='0'; LED6<='1'; LED7<='0';
			when "1000" => LED4<='0'; LED5<='0'; LED6<='0'; LED7<='1';
			when others => LED4<='0'; LED5<='0'; LED6<='0'; LED7<='0';	
		end case;
	end if;
	end process;
end Behavioral;

