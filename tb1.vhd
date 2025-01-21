library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb1 is
end entity;

architecture test of tb1 is
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

component first
	port(
	x, y, clk, reset : in std_logic;
	m : in std_logic_vector(7 downto 0);
	max_capacity: out std_logic);
end component;

for DUT : first use entity work.first(system);

begin

DUT : first port map(
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
		m <= "00000110";
		x <= '0';
		y <= '0';
	wait for 5 ns;
	
	for i in 0 to 10 loop	
			x <= '1';
		wait until rising_edge(clk);
			x <= '0';
		wait for 10 ns;
	end loop;

	wait until rising_edge(clk);
                reset <= '0';
                m <= "11111100";
                x <= '0';
                y <= '0';
	for i in 0 to 20 loop	
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

