-------------------------------------------------------------------------------
-- Title : Entidad Interfaz Entrada
-- Project : Elevator-VHDL
-------------------------------------------------------------------------------
-- File : EntidadInterfazEntrada.vhd
-- Author : AranchaCM
-- Created : 2017/01/09
-- Last modified : 2017/01/09
-------------------------------------------------------------------------------
-- Description :
-- Implements the top entity which encapsulate BloqueadorPisoVoy.vhd 
-- and PisoActual.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EntidadInterfazEntrada is
    Port ( SensorVoy : in  STD_LOGIC_VECTOR (3 downto 0);
			  Motor : in STD_LOGIC_VECTOR (1 downto 0);
           SensorEstoy : in  STD_LOGIC_VECTOR (3 downto 0);
           PisoVoy : out  STD_LOGIC_VECTOR (3 downto 0);
           PisoEstoy : out  STD_LOGIC_VECTOR (3 downto 0)
			  );
end EntidadInterfazEntrada;

architecture Behavioral of EntidadInterfazEntrada is
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