library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity InterfazEntrada is
    Port ( SensorVoy : in  STD_LOGIC_VECTOR (3 downto 0);
			  Motor : in STD_LOGIC_VECTOR (1 downto 0);
           SensorEstoy : in  STD_LOGIC_VECTOR (3 downto 0);
           PisoVoy : out  STD_LOGIC_VECTOR (3 downto 0);
           PisoEstoy : out  STD_LOGIC_VECTOR (3 downto 0)
			  );
end InterfazEntrada;

architecture Behavioral of InterfazEntrada is
component BoqueadorPisoVoy
	Port ( SensorVoy : in  STD_LOGIC_VECTOR (3 downto 0);
			 Motor : in STD_LOGIC_VECTOR (1 downto 0);
          PisoVoy : out  STD_LOGIC_VECTOR (3 downto 0)
			 );
end component;

component PisoActual
	Port ( SensorEstoy : in  STD_LOGIC_VECTOR (3 downto 0);
          PisoEstoy : out  STD_LOGIC_VECTOR (3 downto 0)
			 );
end component;

begin
Inst_BoqueadorPisoVoy: BoqueadorPisoVoy port map(
	SensorVoy => SensorVoy,
	Motor => Motor,
	PisoVoy => PisoVoy
);

Inst_PisoActual: PisoActual port map(
	SensorEstoy => SensorEstoy,
	PisoEstoy => PisoEstoy
);

end Behavioral;