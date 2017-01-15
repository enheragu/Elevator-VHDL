 -------------------------------------------------------------------------------
 -- Title : AlternadorDisplay (tb)
 -- Project : Elevator-VHDL
 -------------------------------------------------------------------------------
 -- File : AlternadorDisplay_tb.vhd
 -- Author :  AlbertoBB
 -- Created : 2016/12/26
 -- Last modified : 2016/12/26
 -------------------------------------------------------------------------------
 -- Description :
 -- Implements the testbench of AlternadorDisplay.vhd
 -------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY AlternadorDisplay_tb IS
END AlternadorDisplay_tb;
 
ARCHITECTURE behavior OF AlternadorDisplay_tb IS 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT AlternadorDisplay
    PORT(
         ControlMotor7s  : IN  std_logic_vector(6 downto 0);
         ControlPuerta7s : IN  std_logic_vector(6 downto 0);
         PisoVoy7s       : IN  std_logic_vector(6 downto 0);
         PisoEstoy7s     : IN  std_logic_vector(6 downto 0);
         Clk             : IN  std_logic;
         A0              : OUT  std_logic;
         A1              : OUT  std_logic;
         A2              : OUT  std_logic;
         A3              : OUT  std_logic;
         Salida7s        : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
	-- SEÑALES
   --Inputs
   signal ControlMotor7s  : std_logic_vector(6 downto 0) := (others => '0');
   signal ControlPuerta7s : std_logic_vector(6 downto 0) := (others => '0');
   signal PisoVoy7s        : std_logic_vector(6 downto 0) := (others => '0');
   signal PisoEstoy7s     : std_logic_vector(6 downto 0) := (others => '0');
   signal Clk             : std_logic := '0';

 	--Outputs
   signal A0              : std_logic;
   signal A1              : std_logic;
   signal A2              : std_logic;
   signal A3              : std_logic;
   signal Salida7s        : std_logic_vector(6 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
	
	-- Vector de pruebas
	TYPE vtest is record
	 A0              : std_logic;
    A1              : std_logic;
    A2              : std_logic;
    A3              : std_logic;
    Salida7s        : std_logic_vector(6 downto 0);
   END RECORD;
   TYPE vtest_vector IS ARRAY (natural RANGE <>) OF vtest;
	CONSTANT test: vtest_vector := (
		(A0=> '0', A1=> '1', A2=> '1', A3=> '1',Salida7s => "1111111"),
		(A0=> '1', A1=> '0', A2=> '1', A3=> '1',Salida7s => "1110000"),
		(A0=> '1', A1=> '1', A2=> '0', A3=> '1',Salida7s => "0001111"),
		(A0=> '1', A1=> '1', A2=> '1', A3=> '0',Salida7s => "0000000")
		 );

BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: AlternadorDisplay PORT MAP (
          ControlMotor7s => ControlMotor7s,
          ControlPuerta7s => ControlPuerta7s,
          PisoVoy7s => PisoVoy7s,
          PisoEstoy7s => PisoEstoy7s,
          Clk => Clk,
          A0 => A0,
          A1 => A1,
          A2 => A2,
          A3 => A3,
          Salida7s => Salida7s
        );
   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
   -- Stimulus process
   stim_proc: process
   begin		
		FOR i IN 0 TO test'HIGH LOOP  
				ControlMotor7s <= "1111111";
				ControlPuerta7s <= "1110000";
				PisoVoy7s <= "0001111";
				PisoEstoy7s <= "0000000";
				WAIT FOR 20 ns;
					ASSERT A0 = test(i).A0 and 
							 A1 = test(i).A1 and
							 A2 = test(i).A2 and
							 A3 = test(i).A3 and 
							 Salida7s = test(i).Salida7s 

							 REPORT "Salida incorrecta." 
						SEVERITY FAILURE;
			END LOOP;
		
			ASSERT false
			REPORT "Simulacion finalizada. Test superado." 
			SEVERITY FAILURE;

      
   end process;

END;
