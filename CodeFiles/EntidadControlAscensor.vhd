library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EntidadControlAscensor is
    Port ( PisoVoy : in  STD_LOGIC_VECTOR (3 downto 0);
           PisoEstoy : in  STD_LOGIC_VECTOR (3 downto 0);
           ControlMotor : out  STD_LOGIC_VECTOR (1 downto 0);
end EntidadControlAscensor;

architecture Behavioral of EntidadControlAscensor is

	signal SigPisoVoy, SigPisoEstoy : INTEGER;

	component DecodificadorBinarioDecimal 
	port (
			EntradaBinaria: in std_logic_vector (3 downto 0);
			SalidaEntera : out  INTEGER
			);
	end component;

	component Comparador
	port (
			PisoVoy: in INTEGER;
			PisoEstoy: INTEGER;
			ControlMotor : out  STD_LOGIC_VECTOR (2 downto 0)
			);
	end component;

begin

	Inst_decodificadorVoy: DecodificadorBinarioDecimal port map (
		PisoVoy => EntradaBinaria, 
		SalidaEntera=> SigPisoVoy	
	);

	Inst_decodificadorEstoy: DecodificadorBinarioDecimal port map (
		PisoEstoy => EntradaBinaria, 
		SalidaEntera => SigPisoEstoy	
	);
	
	Inst_Compoarador: Comparador port map (
		SigPisoVoy => PisoVoy,
		SigPisoEstoy => PisoEstoy, 	
		ControlMotor => ControlMotor
	);

end Behavioral;