 -------------------------------------------------------------------------------
 -- Title : Simulacion Motor y Puerta
 -- Project : Elevator-VHDL
 -------------------------------------------------------------------------------
 -- File : SimulacionMotorPuerta.vhd
 -- Author : EnriqueHE
 -- Created : 2017/01/10
 -- Last modified : 2017/01/10
 -------------------------------------------------------------------------------
 -- Description :
 -- Shows through two 7 segment displays the reaction of the motor and door
 -------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_arith.ALL; 
USE ieee.std_logic_unsigned.ALL;

entity SimulacionMotorPuerta is
    Port ( ControlMotor   : in  STD_LOGIC_vector(1 DOWNTO 0);
           ControlMotor7s : out  STD_LOGIC_vector(6 DOWNTO 0);
			  CLK: in STD_LOGIC;
           ControlPuerta7s : out  STD_LOGIC_vector(6 DOWNTO 0)
			);
end SimulacionMotorPuerta;

architecture Behavioral of SimulacionMotorPuerta is

begin
	process (ControlMotor, CLK)
	begin
	IF rising_edge(CLK) THEN
		case ControlMotor is
			when "00" =>
				ControlMotor7s <= "1111110"; -- Motor Parado, caracter -
				ControlPuerta7s <= "0001000"; -- Puerta abierta, caracter A
			when "01" =>
				ControlMotor7s <= "0100100"; -- Motor Subiendo, caracter S
				ControlPuerta7s <= "0110001"; -- Puerta cerrada, caracter C
			when "10" =>
				ControlMotor7s <= "0000000"; -- Motor Bajando, caracter B
				ControlPuerta7s <= "0110001"; -- Puerta cerrada, caracter C
			
			when others =>						  --Situación imposible:
				ControlMotor7s <= "1111111"; --Soluciona error de timing en el latch
				ControlPuerta7s <= "1111111";--que da si siempre valen 0
 		end case;
	END IF;
 	end process;
end Behavioral;
