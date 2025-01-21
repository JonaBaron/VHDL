library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity testbench is
end entity;

architecture test of testbench is
--clock related signals
signal clk : std_logic;
signal clk_ena : boolean := false;
constant CLK_PERIOD : time := 10 ns; 
--project signals
signal x : std_logic;                       	--sensor in
signal y: std_logic;                        	--sensor out 
signal reset: std_logic;                    	--reset
signal m : std_logic_vector(7 downto 0); 	--max limit (input)
signal max_capacity : std_logic ;  		--max detection (output)

component project
	port(
	x, y, clk, reset : in std_logic;
	m : in std_logic_vector(7 downto 0);
	max_capacity: out std_logic);
end component;
for DUT : project use entity work.project(system);

begin

DUT : project port map(
	x => x,
	y => y,
	clk =>clk,
	reset=> reset,
	m => m,
	max_capacity => max_capacity);
clk <= not clk after CLK_PERIOD/2 when clk_ena else '0';
simu: process

begin
	report("Simulation starting");
		clk_ena <= true;
		reset <= '1';
	wait until rising_edge(clk);
		reset <= '1';
	wait until rising_edge(clk);
		reset <= '0';
		m <= "11111111";
		x <= '0';
		y <= '0';
	wait for 5 ns;
	for i in 0 to 256 loop	
			x <= '1';
		wait until rising_edge(clk);
			x <= '0';
		wait for 10 ns;
	end loop;

	reset <= '1';
	wait for 2 ns;
	reset <= '0';

	wait until rising_edge(clk);
                reset <= '0';
                m <= "00000110";
                x <= '0';
                y <= '0';

	for i in 0 to 10 loop	
			y <= '1';
			x <= '1';
		wait until rising_edge(clk);
			y <= '0';
			x <= '0';
		wait for 10 ns;
	end loop;

	for i in 0 to 5 loop	
			y <= '1';
		wait until rising_edge(clk);
			y <= '0';
		wait for 10 ns;
	end loop;

	
	reset <= '1';
	wait for 2 ns;
	reset <= '0';

	for i in 0 to 6 loop	
			x <= '1';
		wait until rising_edge(clk);
			x <= '0';
		wait for 10 ns;
	end loop;
	
	m <= "00000011";
	
	for i in 0 to 6 loop	
			x <= '1';
		wait until rising_edge(clk);
			x <= '0';
		wait for 10 ns;
	end loop;
	
	for i in 0 to 5 loop	
			y <= '1';
		wait until rising_edge(clk);
			y <= '0';
		wait for 10 ns;
	end loop;
	

	wait for 16 * CLK_PERIOD;
	clk_ena <= false;
	
	report("End simulation");
	wait;

end process;
end architecture;

