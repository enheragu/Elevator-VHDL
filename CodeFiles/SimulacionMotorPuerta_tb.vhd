 -------------------------------------------------------------------------------
 -- Title : Simulacion Motor y Puerta (tb)
 -- Project : Elevator-VHDL
 -------------------------------------------------------------------------------
 -- File : SimulacionMotorPuerta_Tb.vhd
 -- Author : EnriqueHE
 -- Created : 2017/01/10
 -- Last modified : 2017/01/10
 -------------------------------------------------------------------------------
 -- Description :
 -- Implements SimulacionMotorPuerta testbench
 -------------------------------------------------------------------------------
 LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY SimulacionMotorPuerta_tb IS
END SimulacionMotorPuerta_tb;
 
ARCHITECTURE behavior OF SimulacionMotorPuerta_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT SimulacionMotorPuerta
    PORT(
         ControlMotor : IN  std_logic_vector(1 downto 0);
         ControlMotor7s : OUT  std_logic_vector(6 downto 0);
         ControlPuerta7s : OUT  STD_LOGIC_vector(6 DOWNTO 0)
        );
    END COMPONENT;

   --Inputs
   signal ControlMotor : std_logic_vector(1 downto 0) := (others => '0');
 	--Outputs
   signal ControlMotor7s : std_logic_vector(6 downto 0);
   signal ControlPuerta7s : STD_LOGIC_vector(6 DOWNTO 0);

	--estructura tipo tecord
	TYPE vtest is record
      ControlMotor   : std_logic_vector(1 DOWNTO 0);
      ControlMotor7s : std_logic_vector(6 DOWNTO 0);
	  ControlPuerta7s : STD_LOGIC_vector(6 DOWNTO 0);
    END RECORD;
	
    TYPE vtest_vector IS ARRAY (natural RANGE <>) OF vtest;
	
	CONSTANT test: vtest_vector := (
		(ControlMotor => "00", ControlMotor7s => "0000001", ControlPuerta7s => "1110111"), -- Motor parado, Puerta abierta
		(ControlMotor => "01", ControlMotor7s => "1011011", ControlPuerta7s => "1001110"), -- Motor subida, puerta cerrada
		(ControlMotor => "10", ControlMotor7s => "1111111", ControlPuerta7s => "1001110") -- Motor bajada, puerta cerrada
		 );

BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: SimulacionMotorPuerta PORT MAP (
          ControlMotor => ControlMotor,
          ControlMotor7s => ControlMotor7s,
          ControlPuerta7s => ControlPuerta7s
        );

	tb: PROCESS 
		BEGIN
			FOR i IN 0 TO test'HIGH LOOP  
				ControlMotor <= test(i).ControlMotor;
				WAIT FOR 20 ns;
					ASSERT ControlMotor7s = test(i).ControlMotor7s
						REPORT "Salida incorrecta." 
						SEVERITY FAILURE;
						
					ASSERT ControlPuerta7s = test(i).ControlPuerta7s
						REPORT "Salida incorrecta." 
						SEVERITY FAILURE;
			END LOOP;
		
			ASSERT false
			REPORT "Simulacion finalizada. Test superado." 
			SEVERITY FAILURE;
		END PROCESS;


END;
