-------------------------------------------------------------------------------
 -- Title : DivisorFrecuencia
 -- Project : Elevator-VHDL
 -------------------------------------------------------------------------------
 -- File : Comparador.vhd
 -- Author : AlbertoBB
 -- Created : 2017/01/10
 -- Last modified : 2017/01/11
 -------------------------------------------------------------------------------
 -- Description :
 -- 
 -------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DivisorFrecuencia is
    Port ( ControlMotor7s  : in  STD_LOGIC_VECTOR(7 downto 0);
           ControlPuerta7s : in  STD_LOGIC_VECTOR(7 downto 0);
           PisoVoy7s       : in  STD_LOGIC_VECTOR(7 downto 0);
           PisoEstoy7s     : in  STD_LOGIC_VECTOR(7 downto 0);
           Clk             : in  STD_LOGIC; 
           A0              : out  STD_LOGIC;
           A1              : out  STD_LOGIC;
           A2              : out  STD_LOGIC;
           A3              : out  STD_LOGIC;
		   Salida7s        : out  STD_LOGIC_VECTOR(7 downto 0);	
	);
end DivisorFrecuencia;

architecture Behavioral of DivisorFrecuencia is
		signal contador: integer range 0 to 16 := 0; --escala: ESCALA/2
		-- salidas
		signal SigA0       : std_logic;
		signal SigA1       : std_logic;
		signal SigA2       : std_logic;
		signal SigA3       : std_logic;
		signal SigSalida7s : std_logic_vector(7 downto 0);
begin
	process (reset, Clk) 
	begin
		if rising_edge(Clk) then
			if (contador = 16) then
				contador <= 0;
			else
				contador <= contador+1;
			end if;
        end if; 
		  
		if rising_edge(Clk) then
			if (contador < 4) then 
				SigA0<='1' ; SigA1 <='0'; SigA2 <='0'; SigA3 <='0';
          		SigSalida7s <= ControlMotor7s;
			end if;
			if (contador >= 4 and contador <8) then 
				SigA1<='0' ; SigA1<='1'; SigA2<='0'; SigA3<='0';
				SigSalida7s <= ControlPuerta7s;
			end if;
			if (contador >= 8 and contador <12) then 
				SigA0 <='0' ; SigA1 <='0'; SigA2 <='1'; SigA3 <='0';
				SigSalida7s <= PisoVoy7s;
			end if;
			if (contador >= 12 and contador <16) then 
				SigA3<='0' ; SigA1<='0'; SigA2<='0'; SigA3<='1';
				SigSalida7s <= PisoEstoy7s;
			end if;
        end if; 
		  
	end process;
		
A0 <= SigA0;
A1 <= SigA1;
A2 <= SigA2;
A3 <= SigA3;
Salida7s <= SigSalida7s;

end Behavioral;
