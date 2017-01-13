-------------------------------------------------------------------------------
-- Title : Bloqueador Piso Voy (tb)
-- Project : Elevator-VHDL
-------------------------------------------------------------------------------
-- File : BloqueadorPisoVoy_tb.vhd
-- Author : AranchaCM
-- Created : 2016/12/26
-- Last modified : 2017/01/11
-------------------------------------------------------------------------------
-- Description :
-- Implements athe testbench of BloqueadorPisoVoy.vhd
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY BloqueadorPisoVoy_tb IS
END BloqueadorPisoVoy_tb;
 
ARCHITECTURE behavior OF BloqueadorPisoVoy_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT BoqueadorPisoVoy
    PORT(
         Motor : IN  std_logic_vector(1 downto 0);
         SensorVoy : IN  std_logic_vector(3 downto 0);
			CLK: in STD_LOGIC;
         PisoVoy : OUT  std_logic_vector(3 downto 0);
			MemPisoVoy1, MemPisoVoy2 :  out  STD_LOGIC_VECTOR(3 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal Motor : std_logic_vector(1 downto 0) := (others => '0');
   signal SensorVoy : std_logic_vector(3 downto 0) := (others => '0');
	signal CLK: std_logic;

 	--Outputs
   signal PisoVoy : std_logic_vector(3 downto 0);
	signal MemPisoVoy1 :  STD_LOGIC_VECTOR(3 downto 0);
	signal MemPisoVoy2 :  STD_LOGIC_VECTOR(3 downto 0);
	
	-- Clock period definitions
   constant CLK_period : time := 10 ns;
 	
	type vtest is record
				Motor : std_logic_vector(1 downto 0);
				SensorVoy : std_logic_vector(3 downto 0);
				PisoVoy : std_logic_vector(3 downto 0);
				MemPisoVoy1 :  STD_LOGIC_VECTOR(3 downto 0);
				MemPisoVoy2 :  STD_LOGIC_VECTOR(3 downto 0);
	end record;
	
	type vtest_vector is array (natural range <>) of vtest;
	
	constant test: vtest_vector := (
				(Motor => "00", SensorVoy => "0001", PisoVoy => "0001", MemPisoVoy1 => "0000", MemPisoVoy2 => "0000"),
				(Motor => "01", SensorVoy => "1000", PisoVoy => "0001", MemPisoVoy1 => "1000", MemPisoVoy2 => "0000"),
				(Motor => "01", SensorVoy => "0100", PisoVoy => "0001", MemPisoVoy1 => "1000", MemPisoVoy2 => "0100"),
				(Motor => "01", SensorVoy => "0000", PisoVoy => "0001", MemPisoVoy1 => "1000", MemPisoVoy2 => "0100"),
				(Motor => "00", SensorVoy => "0000", PisoVoy => "0001", MemPisoVoy1 => "0100", MemPisoVoy2 => "0000")
				);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BoqueadorPisoVoy PORT MAP (
          Motor => Motor,
          SensorVoy => SensorVoy,
			 CLK => CLK,
			 MemPisoVoy1 => MemPisoVoy1,
			 MemPisoVoy2 => MemPisoVoy2,
          PisoVoy => PisoVoy
        ); 
		  
	-- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for Clk_period/2;
		CLK <= '1';
		wait for Clk_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
   begin		
		
		for i in 0 to test'high loop
				Motor <= test(i).Motor;
				SensorVoy <= test(i).SensorVoy;
				wait for 200 ns;
				assert PisoVoy = test(i).PisoVoy and
						 MemPisoVoy1 = test(i).MemPisoVoy1 and
						 MemPisoVoy2 = test(i).MemPisoVoy2
					report "salida incorrecta"
					severity failure;
				end loop;
		
      assert false
			report "fin de la simulación"
			severity failure;
      -- insert stimulus here 
   end process;
END;