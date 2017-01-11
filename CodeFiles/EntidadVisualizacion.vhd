 -------------------------------------------------------------------------------
 -- Title : Entidad Visualización
 -- Project : Elevator-VHDL
 -------------------------------------------------------------------------------
 -- File : EntidadVisualizacion.vhd
 -- Author : AlbertoBB
 -- Created : 2017/01/11
 -- Last modified : 2017/01/11
 -------------------------------------------------------------------------------
 -- Description :
 -------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EntidadVisualizacion is
    Port ( PisoVoy         : in  STD_LOGIC_VECTOR (3 downto 0);
           PisoEstoy       : in  STD_LOGIC_VECTOR (3 downto 0);
           ControlMotor7s  : in  STD_LOGIC_VECTOR (6 downto 0);
           ControlPuerta7s : in  STD_LOGIC_VECTOR (6 downto 0);
           CLK 			   : in STD_LOGIC;
           A0              : out  STD_LOGIC;
           A1              : out  STD_LOGIC;
           A2              : out  STD_LOGIC;
           A3              : out  STD_LOGIC;
		   Salida7s        : out  STD_LOGIC_VECTOR(6 downto 0)
		  );
end EntidadVisualizacion;

architecture Behavioral of EntidadVisualizacion is


	component DivisorFrecuencia 
	port (
		   ControlMotor7s  : in  STD_LOGIC_VECTOR(6 downto 0);
           ControlPuerta7s : in  STD_LOGIC_VECTOR(6 downto 0);
           PisoVoy7s         : in  STD_LOGIC_VECTOR(6 downto 0);
           PisoEstoy7s       : in  STD_LOGIC_VECTOR(6 downto 0);
           Clk             : in  STD_LOGIC; 
           A0              : out  STD_LOGIC;
           A1              : out  STD_LOGIC;
           A2              : out  STD_LOGIC;
           A3              : out  STD_LOGIC;
		   Salida7s        : out  STD_LOGIC_VECTOR(6 downto 0)
			);
	end component;

	component Decodificador7s
	port (
		   EntradaPisoBinaria   : in  STD_LOGIC_vector(3 DOWNTO 0);
           SalidaPiso7s : out  STD_LOGIC_vector(6 DOWNTO 0)
			);
	end component;
	
	--signal declaration
	signal sigPisoEstoy7s, sigPisoVoy7s : STD_LOGIC_VECTOR(6 downto 0);
	
begin

	Inst_Decodificador7sVoy: Decodificador7s port map (
		EntradaPisoBinaria => PisoVoy, 
		SalidaPiso7s => sigPisoVoy7s  	
	);

	Inst_Decodificador7sEstoy: Decodificador7s port map (
		EntradaPisoBinaria => PisoEstoy, 
		SalidaPiso7s => sigPisoEstoy7s
	);
	
	Inst_DivisorFrecuencia: DivisorFrecuencia port map (
	    ControlMotor7s => ControlMotor7s,
        ControlPuerta7s => ControlPuerta7s, 
        PisoVoy7s => sigPisoVoy7s,
        PisoEstoy7s => sigPisoEstoy7s,  
        Clk => Clk, 
        A0 => A0, 
        A1 => A1, 
        A2 => A2, 
        A3 => A3,  
	    Salida7s => Salida7s 
	);

end Behavioral;