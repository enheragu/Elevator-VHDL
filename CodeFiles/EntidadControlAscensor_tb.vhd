 -------------------------------------------------------------------------------
 -- Title : Entidad Control Ascensor (tb)
 -- Project : Elevator-VHDL
 -------------------------------------------------------------------------------
 -- File : EntidadControlAScensor_tb.vhd
 -- Author : EnriqueHE
 -- Created : 2017/01/03
 -- Last modified : 2017/01/03
 -------------------------------------------------------------------------------
 -- Description :
 -- Implements the testbench of EntidadControlAScensor.vhd
 -------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
 
ENTITY EntidadControlAscensor_tb IS
END EntidadControlAscensor_tb;
 
ARCHITECTURE behavior OF EntidadControlAscensor_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT EntidadControlAscensor
    PORT(
         PisoVoy : in  STD_LOGIC_VECTOR (3 downto 0);
         PisoEstoy : in  STD_LOGIC_VECTOR (3 downto 0);
         ControlMotor : out  STD_LOGIC_VECTOR (1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PisoVoy : STD_LOGIC_VECTOR (3 downto 0);
	signal PisoEstoy : STD_LOGIC_VECTOR (3 downto 0);

 	--Outputs
   signal ControlMotor : STD_LOGIC_VECTOR(1 downto 0);
	
	type vtest is record 
			PisoVoy : STD_LOGIC_VECTOR (3 downto 0);
			PisoEstoy : STD_LOGIC_VECTOR (3 downto 0);
         ControlMotor : STD_LOGIC_VECTOR(1 downto 0);
	end record;
	
	type vtest_vector is array (natural range <>) of vtest;
 
   constant test: vtest_vector := ( 
				 (PisoVoy => "0001", PisoEstoy => "0001", ControlMotor => "00"),
				 (PisoVoy => "0100", PisoEstoy => "0001", ControlMotor => "01"),
				 (PisoVoy => "0100", PisoEstoy => "0100", ControlMotor => "00"),				 
				 (PisoVoy => "0001", PisoEstoy => "0100", ControlMotor => "10"),
				 (PisoVoy => "0001", PisoEstoy => "0001", ControlMotor => "00")		 
	);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: EntidadControlAscensor PORT MAP (
          PisoVoy => PisoVoy,
          PisoEstoy => PisoEstoy,
			 ControlMotor => ControlMotor
        );

	tb: process
	
	begin
		for i in 0 to test'high loop
			PisoVoy <= test(i).PisoVoy;
			PisoEstoy <= test(i).PisoEstoy;
			wait for 20 ns;
			assert ControlMotor = test(i).ControlMotor
				report "salida incorrecta"
				severity failure;
		end loop;
		
		assert false
			report "simulacion finalizada. Test superado."
			severity failure;
				
	end process;

END;