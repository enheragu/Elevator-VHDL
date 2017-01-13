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
    Port ( Motor : in  STD_LOGIC_VECTOR(1 downto 0);
           SensorVoy : in  STD_LOGIC_VECTOR (3 downto 0);
			  CLK: in STD_LOGIC;
           PisoVoy : out  STD_LOGIC_VECTOR(3 downto 0);
			  MemPisoVoy1, MemPisoVoy2 :  out  STD_LOGIC_VECTOR(3 downto 0)
	 );
end BoqueadorPisoVoy;

architecture behavioral of BoqueadorPisoVoy is

signal sigPisoVoy: STD_LOGIC_VECTOR (PisoVoy'range):= "0000";
signal sigMemPisoVoy1, sigMemPisoVoy2: STD_LOGIC_VECTOR (PisoVoy'range):= "0000";
signal delay: integer range 0 to 50000000:= 0; -- 1 second at 50MHz
begin

	process (SensorVoy, Motor, CLK)	
	begin
		if rising_edge(CLK) then 
			if (SensorVoy = "0001" or
				 SensorVoy = "0010" or 
				 SensorVoy = "0100" or 
				 SensorVoy = "1000") then
						
				if Motor = "00" and 
				   sigMemPisoVoy1 = "0000" and 
				   sigMemPisoVoy2 = "0000" then
					-- sentencias:
					sigPisoVoy <= SensorVoy;			
					
				elsif Motor /= "00" and 
				      SensorVoy /= sigPisoVoy and 
				      sigMemPisoVoy1 = "0000" then
						-- sentencias:
						sigMemPisoVoy1 <= SensorVoy;
					
				elsif Motor /= "00" and 
				      SensorVoy /= sigMemPisoVoy1 and 
				      sigMemPisoVoy1 /= "0000"  and 
						sigMemPisoVoy2 = "0000" then
						-- sentencias:
						sigMemPisoVoy2 <= SensorVoy;
					
				end if;
			end if;

			if Motor = "00" and 
			   sigMemPisoVoy1 /= "0000" then
				-- sentencias:
				delay <= delay+1;
				if (delay = 50000000) then --waits 1s before closing the door again
					sigPisoVoy <= sigMemPisoVoy1;
					sigMemPisoVoy1 <= "0000";
					delay <= 0;
				end if;
			elsif Motor = "00" and sigMemPisoVoy1 = "0000" then
				sigMemPisoVoy1 <= sigMemPisoVoy2;
				sigMemPisoVoy2 <= "0000";
			end if;
		end if;
	end process;
	
	MemPisoVoy1 <= sigMemPisoVoy1;
	MemPisoVoy2 <= sigMemPisoVoy2;
	PisoVoy <= sigPisoVoy;

end behavioral;