 -------------------------------------------------------------------------------
 -- Title : Entidad Ascensor
 -- Project : Elevator-VHDL
 -------------------------------------------------------------------------------
 -- File : EntidadAscensor.vhd
 -- Author : AranchaCM, AlbertoBB, EnriqueHA
 -- Created : 2017/01/11
 -- Last modified : 2017/01/11
 -------------------------------------------------------------------------------
 -- Description :
 -- We join all the previous entities for the operation of the elevator
 -------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EntidadAscensor is
    Port ( SensorVoy         : in  STD_LOGIC_VECTOR (3 downto 0);
           SensorEstoy       : in  STD_LOGIC_VECTOR (3 downto 0);
           CLK 			   : in STD_LOGIC;
           A0              : out  STD_LOGIC;
           A1              : out  STD_LOGIC;
           A2              : out  STD_LOGIC;
           A3              : out  STD_LOGIC;
			  Salida7s        : out  STD_LOGIC_VECTOR(7 downto 0);
			  LED: OUT STD_LOGIC_VECTOR (7 downto 0)
		  );
end EntidadAscensor;

architecture Behavioral of EntidadAscensor is

	component EntidadVisualizacion 
	 Port ( PisoVoy         : in  STD_LOGIC_VECTOR (3 downto 0);
			  PisoEstoy       : in  STD_LOGIC_VECTOR (3 downto 0);
			  ControlMotor7s  : in  STD_LOGIC_VECTOR (6 downto 0);
			  ControlPuerta7s : in  STD_LOGIC_VECTOR (6 downto 0);
			  CLK 			   : in STD_LOGIC;
			  A0              : out  STD_LOGIC;
			  A1              : out  STD_LOGIC;
			  A2              : out  STD_LOGIC;
			  A3              : out  STD_LOGIC;
			  Salida7s        : out  STD_LOGIC_VECTOR(7 downto 0)
		  );
	end component;

	component SimulacionMotorPuerta 
		 Port ( ControlMotor   : in  STD_LOGIC_vector(1 DOWNTO 0);
			     CLK: in STD_LOGIC;
				  ControlMotor7s : out  STD_LOGIC_vector(6 DOWNTO 0);
				  ControlPuerta7s : out  STD_LOGIC_vector(6 DOWNTO 0)
			  );
	end component;

	component EntidadControlAscensor 
		 Port ( PisoVoy : in  STD_LOGIC_VECTOR (3 downto 0);
				  PisoEstoy : in  STD_LOGIC_VECTOR (3 downto 0);
			     CLK: in STD_LOGIC;
				  ControlMotor : out  STD_LOGIC_VECTOR (1 downto 0)
			 );
	end component;

	component EntidadInterfazEntrada 
	    Port ( SensorVoy : in  STD_LOGIC_VECTOR (3 downto 0);
			     Motor : in STD_LOGIC_VECTOR (1 downto 0);
	           SensorEstoy : in  STD_LOGIC_VECTOR (3 downto 0);
			     CLK: in STD_LOGIC;
	           PisoVoy : out  STD_LOGIC_VECTOR (3 downto 0);
	           PisoEstoy : out  STD_LOGIC_VECTOR (3 downto 0);
				  MemPisoVoy1, MemPisoVoy2 :  out  STD_LOGIC_VECTOR(3 downto 0)
			  );
	end component;
	
	component DecodificadorLED 	
		PORT(
			  MemPisoVoy1, MemPisoVoy2 :  in  STD_LOGIC_VECTOR(3 downto 0);
			  CLK: in STD_LOGIC;
			  LED: OUT STD_LOGIC_VECTOR (7 downto 0)
		);
	end component;
		
	--signal declaration
	signal sigPisoVoy, sigPisoEstoy : STD_LOGIC_VECTOR(3 downto 0);
	signal sigControlmotor: STD_LOGIC_VECTOR(1 downto 0);
	signal sigControlMotor7s, sigControlPuerta7s : STD_LOGIC_VECTOR(6 downto 0);
	signal sigMemPisoVoy1, sigMemPisoVoy2: STD_LOGIC_VECTOR(3 downto 0);
	
begin

	Inst_EntidadInterfazEntrada: EntidadInterfazEntrada port map (
		  SensorVoy => SensorVoy,
	     Motor => sigControlMotor,
        SensorEstoy =>  SensorEstoy,
		  CLK => CLK,
        PisoVoy => sigPisoVoy,
        PisoEstoy => sigPisoEstoy,
		  MemPisoVoy1 => sigMemPisoVoy1,
		  MemPisoVoy2 => sigMemPisoVoy2
	);

	Inst_EntidadControlAscensor: EntidadControlAscensor port map (
		  PisoVoy => sigPisoVoy, 
		  PisoEstoy => sigPisoEstoy,
		  CLK => CLK,
		  ControlMotor => sigControlmotor
	);
	
	Inst_SimulacionMotorPuerta: SimulacionMotorPuerta port map (
	     ControlMotor => sigControlmotor,
		  CLK => CLK,
        ControlMotor7s => sigControlMotor7s,
        ControlPuerta7s => sigControlPuerta7s
	);

	Inst_EntidadVisualizacion: EntidadVisualizacion port map (
	     ControlMotor7s => sigControlMotor7s,
        ControlPuerta7s => sigControlPuerta7s, 
        PisoVoy => sigPisoVoy,
        PisoEstoy => sigPisoEstoy,  
        Clk => Clk, 
        A0 => A0, 
        A1 => A1, 
        A2 => A2, 
        A3 => A3,  
	     Salida7s => Salida7s 
	);
	
	Inst_DecodificadorLED: DecodificadorLED port map (
		  MemPisoVoy1 => sigMemPisoVoy1,
		  MemPisoVoy2 => sigMemPisoVoy2,
		  CLK => CLK,
		  LED => LED
	);


end Behavioral;


