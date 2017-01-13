-------------------------------------------------------------------------------
-- Title : Bloqueador Piso Voy (tb)
-- Project : Elevator-VHDL
-------------------------------------------------------------------------------
-- File : BloqueadorPisoVoy_tb.vhd
-- Author : AranchaCM
-- Created : 2016/12/26
-- Last modified : 2017/01/13
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
    COMPONENT BloqueadorPisoVoy
    Port ( Motor : IN  STD_LOGIC_VECTOR(1 downto 0);
	   	SensorVoy : IN  STD_LOGIC_VECTOR (3 downto 0);
	   	CLK: IN STD_LOGIC;
	   	PisoVoy : OUT  STD_LOGIC_VECTOR(3 downto 0);
	   	MemPisoVoy1 :  OUT  STD_LOGIC_VECTOR(3 downto 0);
	   	MemPisoVoy2 :  OUT  STD_LOGIC_VECTOR(3 downto 0)
		);
    END COMPONENT;
    
	--Inputs
	signal Motor : std_logic_vector (1 downto 0):= (others => '0');
	signal SensorVoy : std_logic_vector(3 downto 0):= (others => '0');
	signal CLK: std_logic;

 	--Outputs
	signal PisoVoy : std_logic_vector(3 downto 0);
	signal MemPisoVoy1 :  STD_LOGIC_VECTOR(3 downto 0);
	signal MemPisoVoy2 : STD_LOGIC_VECTOR(3 downto 0);
	
	-- Clock period definitions
   	constant CLK_period : time := 10 ns;
	
	type vtest is record 
			Motor : std_logic_vector (1 downto 0);
			SensorVoy : std_logic_vector(3 downto 0);
			PisoVoy : std_logic_vector(3 downto 0);
			MemPisoVoy1 :  STD_LOGIC_VECTOR(3 downto 0);
			MemPisoVoy2 : STD_LOGIC_VECTOR(3 downto 0);
	end record;
	
	type vtest_vector is array (natural range <>) of vtest;
 
   constant test: vtest_vector := ( 
				 --Ascensor Parado y nada pulsado
				 (Motor => "00", SensorVoy => "0000", PisoVoy => "0000", 
				 MemPisoVoy1 => "0000", MemPisoVoy2 => "0000"),
				 --Ascensor Parado y pulso planta 2
					--> se guarda en PisoVoy
				 (Motor => "00", SensorVoy => "0010", PisoVoy => "0010", 
				 MemPisoVoy1 => "0000", MemPisoVoy2 => "0000"),
				 --Ascensor en movimiento y nada pulsado
				 (Motor => "01", SensorVoy => "0000", PisoVoy => "0010", 
				 MemPisoVoy1 => "0000", MemPisoVoy2 => "0000"),
				 --Ascensor en movimiento y pulso planta 4: PisoVoy "lleno"
					--> se guarda en MemPisoVoy1
				 (Motor => "01", SensorVoy => "1000", PisoVoy => "0010", 
				 MemPisoVoy1 => "1000", MemPisoVoy2 => "0000"),
				 --Ascensor en movimiento y pulso planta 1: 
				 --PisoVoy y MemPisoVoy1 "lleno" 
					--> se guarda en MemPisoVoy2
				 (Motor => "01", SensorVoy => "0001", PisoVoy => "0010", 
				 MemPisoVoy1 => "1000", MemPisoVoy2 => "0001"),
				 --Ascensor en movimiento y nada pulsado
				 (Motor => "01", SensorVoy => "0000", PisoVoy => "0010", 
				 MemPisoVoy1 => "1000", MemPisoVoy2 => "0001"),
				 --Ascensor Parado y nada pulsado 
					--> Espera un tiempo con las puertas abiertas
				 (Motor => "00", SensorVoy => "0000", PisoVoy => "0010", 
				 MemPisoVoy1 => "1000", MemPisoVoy2 => "0001"),
				 --Ascensor Parado, nada pulsado: MemPisoVoy1 "lleno",
				 --tras pasar el tiempo delay 
					--> Pasa el dato de MemPisoVoy1 a PisoVoy
				 (Motor => "00", SensorVoy => "0000", PisoVoy => "1000", 
				 MemPisoVoy1 => "0000", MemPisoVoy2 => "0001"),
				 --Ascensor Parado, nada pulsado: MemPisoVoy2 "lleno"
					--> Pasa el dato de MemPisoVoy2 a MemPisoVoy1
				 (Motor => "00", SensorVoy => "0000", PisoVoy => "1000", 
				 MemPisoVoy1 => "0001", MemPisoVoy2 => "0000"), 
				 --Ascensor en movimiento y nada pulsado				 
				 (Motor => "10", SensorVoy => "0000", PisoVoy => "1000", 
				 MemPisoVoy1 => "0001", MemPisoVoy2 => "0000"),
				 --Ascensor Parado y nada pulsado 
					--> Espera un tiempo con las puertas abiertas
				 (Motor => "00", SensorVoy => "0000", PisoVoy => "1000", 
				 MemPisoVoy1 => "0001", MemPisoVoy2 => "0000"),
				 --Ascensor Parado, nada pulsado: MemPisoVoy1 "lleno",
				 --tras pasar el tiempo delay 
					--> Pasa el dato de MemPisoVoy1 a PisoVoy
				 (Motor => "00", SensorVoy => "0000", PisoVoy => "0001", 
				 MemPisoVoy1 => "0000", MemPisoVoy2 => "0000"),
				 --Ascensor Parado, nada pulsado: MemPisoVoy2 "lleno"
					--> Pasa el dato de MemPisoVoy2 a MemPisoVoy1
				 (Motor => "00", SensorVoy => "0000", PisoVoy => "0001", 
				 MemPisoVoy1 => "0000", MemPisoVoy2 => "0000"),
				 --Ascensor en movimiento y nada pulsado	
				 (Motor => "01", SensorVoy => "0000", PisoVoy => "0001", 
				 MemPisoVoy1 => "0000", MemPisoVoy2 => "0000"),
				 --Ascensor Parado y nada pulsado y nada en variables de "memoria" 
					--> Se mantiene en PisoVoy el último piso pulsado
				 (Motor => "00", SensorVoy => "0000", PisoVoy => "0001", 
				 MemPisoVoy1 => "0000", MemPisoVoy2 => "0000")
	);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BloqueadorPisoVoy PORT MAP (
			Motor => Motor,
			SensorVoy => SensorVoy,
			CLK => CLK,
			PisoVoy => PisoVoy,
			MemPisoVoy1 => MemPisoVoy1,
			MemPisoVoy2 => MemPisoVoy2
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   tb: process
	
	begin
		
		for i in 0 to 5 loop
			SensorVoy <= test(i).SensorVoy;
			Motor <= test(i).Motor;
			wait for 94 ns;
			assert PisoVoy = test(i).PisoVoy and
					 MemPisoVoy1 = test (i).MemPisoVoy1 and
					 MemPisoVoy2 = test (i).MemPisoVoy2
				report "Salida Incorrecta"
				severity failure;
		end loop;
		
		wait for CLK_period/2;
		
		SensorVoy <= test(6).SensorVoy;
		Motor <= test(6).Motor;
		--Tiempo que espera con las puertas abiertas antes de pasar
		--la variable MemPisoVoy1 (delay = 5*CLK_period para la simulación)
		--EL TIEMPO REAL ES MAYOR PARA QUE EN LA PLACA PUEDA VERSE 
		--EL CAMBIO delay = 50000000*CLK_period
		wait for CLK_period*5;
		assert PisoVoy = test(6).PisoVoy and
				 MemPisoVoy1 = test(6).MemPisoVoy1 and
				 MemPisoVoy2 = test(6).MemPisoVoy2
			report "Salida Incorrecta"
			severity failure;
		
		SensorVoy <= test(7).SensorVoy;
		Motor <= test(7).Motor;
		--Tiempo que tarda en pasar la variable MemPisoVoy1 a PisoVoy
		wait for CLK_period; --un ciclo de reloj
		assert PisoVoy = test(7).PisoVoy and
				 MemPisoVoy1 = test(7).MemPisoVoy1 and
				 MemPisoVoy2 = test(7).MemPisoVoy2
			report "Salida Incorrecta"
			severity failure;
		
		SensorVoy <= test(8).SensorVoy;
		Motor <= test(8).Motor;
		--Tiempo que tarda en pasar la variable MemPisoVoy2 a MemPisoVoy1
		wait for CLK_period; --un ciclo de reloj
		assert PisoVoy = test(8).PisoVoy and
				 MemPisoVoy1 = test(8).MemPisoVoy1 and
				 MemPisoVoy2 = test(8).MemPisoVoy2
			report "Salida Incorrecta"
			severity failure;
			
		SensorVoy <= test(9).SensorVoy;
		Motor <= test(9).Motor;
		wait for 100 ns;
		assert PisoVoy = test(9).PisoVoy and
				 MemPisoVoy1 = test(9).MemPisoVoy1 and
				 MemPisoVoy2 = test(9).MemPisoVoy2
			report "Salida Incorrecta"
			severity failure;
		
		SensorVoy <= test(10).SensorVoy;
		Motor <= test(10).Motor;
		--Tiempo que espera con las puertas abiertas antes de pasar
		--la variable MemPisoVoy1 (delay = 5*CLK_period para la simulación)
		--EL TIEMPO REAL ES MAYOR PARA QUE EN LA PLACA PUEDA VERSE 
		--EL CAMBIO delay = 50000000*CLK_period
		wait for CLK_period*5;
		assert PisoVoy = test(10).PisoVoy and
				 MemPisoVoy1 = test(10).MemPisoVoy1 and
				 MemPisoVoy2 = test(10).MemPisoVoy2
			report "Salida Incorrecta"
			severity failure;
		
		SensorVoy <= test(11).SensorVoy;
		Motor <= test(11).Motor;
		--Tiempo que tarda en pasar la variable MemPisoVoy1 a PisoVoy
		wait for CLK_period; --un ciclo de reloj
		assert PisoVoy = test(11).PisoVoy and
				 MemPisoVoy1 = test(11).MemPisoVoy1 and
				 MemPisoVoy2 = test(11).MemPisoVoy2
			report "Salida Incorrecta"
			severity failure;
		
		SensorVoy <= test(12).SensorVoy;
		Motor <= test(12).Motor;
		--Tiempo que tarda en pasar la variable MemPisoVoy2 a MemPisoVoy1
		wait for CLK_period; --un ciclo de reloj
		assert PisoVoy = test(12).PisoVoy and
				 MemPisoVoy1 = test(12).MemPisoVoy1 and
				 MemPisoVoy2 = test(12).MemPisoVoy2
			report "Salida Incorrecta"
			severity failure;
		
		for j in 13 to test'high loop
			SensorVoy <= test(j).SensorVoy;
			Motor <= test(j).Motor;
			wait for 94 ns;
			assert PisoVoy = test(j).PisoVoy and
					 MemPisoVoy1 = test(j).MemPisoVoy1 and
					 MemPisoVoy2 = test(j).MemPisoVoy2
				report "Salida Incorrecta"
				severity failure;
		end loop;
		
		assert false
			report "simulacion finalizada. Test SUPERADO."
			severity failure;
				
	end process;
	
END;