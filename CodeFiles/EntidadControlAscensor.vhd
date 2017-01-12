 -------------------------------------------------------------------------------
 -- Title : Entidad Control Ascensor
 -- Project : Elevator-VHDL
 -------------------------------------------------------------------------------
 -- File : EntidadControlAScensor.vhd
 -- Author : EnriqueHE
 -- Created : 2017/01/03
 -- Last modified : 2017/01/09
 -------------------------------------------------------------------------------
 -- Description :
 -- Implements the top entity which coordinates DecodificadorBinarioEntero.vhd 
 -- and Comparador.vhd
 -------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EntidadControlAscensor is
    Port ( PisoVoy : in  STD_LOGIC_VECTOR (3 downto 0);
           PisoEstoy : in  STD_LOGIC_VECTOR (3 downto 0);
			  CLK: in STD_LOGIC;
           ControlMotor : out  STD_LOGIC_VECTOR (1 downto 0)
			  );
end EntidadControlAscensor;

architecture Behavioral of EntidadControlAscensor is


	component DecodificadorBinarioEntero 
	port (
			EntradaBinaria: in std_logic_vector (3 downto 0);
			SalidaEntera : out  INTEGER
			);
	end component;

	component Comparador
	port (
			PisoVoy: in INTEGER;
			PisoEstoy: in INTEGER;
			CLK: in STD_LOGIC;
			ControlMotor : out  STD_LOGIC_VECTOR (1 downto 0)
			);
	end component;
	
	--signal declaration
	signal SigPisoVoy, SigPisoEstoy : INTEGER;
	
begin

	Inst_decodificadorVoy: DecodificadorBinarioEntero port map (
		EntradaBinaria => PisoVoy, 
		SalidaEntera => SigPisoVoy  	
	);

	Inst_decodificadorEstoy: DecodificadorBinarioEntero port map (
		EntradaBinaria => PisoEstoy, 
		SalidaEntera => SigPisoEstoy
	);
	
	Inst_Comparador: Comparador port map (
		PisoVoy => SigPisoVoy,
		PisoEstoy => SigPisoEstoy, 
		CLK => CLK,
		ControlMotor => ControlMotor
	);

end Behavioral;