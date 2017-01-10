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
           ControlPuerta7s : out  STD_LOGIC_vector(6 DOWNTO 0)
			);
end SimulacionMotorPuerta;

architecture Behavioral of SimulacionMotorPuerta is

begin
	proces (ControlMotor)

		case ControlMotor is
			when "00" =>
				ControlMotor7s <= "0000001"
				ControlPuerta7s <= "1110111"
			when "01" =>
				ControlMotor7s <= "1011011"
				ControlPuerta7s <= "1001110"
			when "10" =>
				ControlMotor7s <= "1111111"
				ControlPuerta7s <= "1001110"
 		end case;
 	end proces;
end Behavioral;
