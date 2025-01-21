library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity project is 

port( 	x : in std_logic; 			--sensor in
	y: in std_logic;  			--sensor out 
	clk: in std_logic;			--clock
	reset: in std_logic;			--reset
	m : in std_logic_vector(7 downto 0); 	--max limit (input)
	max_capacity : out std_logic);		--max detection (output)
end;

architecture system of project is

signal max_q : std_logic_vector(7 downto 0);
signal max_next : std_logic_vector(7 downto 0);

begin

--Register
myProcess: process(clk, reset)
begin

IF reset = '1' THEN
	max_q <= (others=> '0');
ELSIF((clk'event) and (clk = '1')) THEN
	max_q <= max_next; 
end IF; 

end process;

-- next-state logic
max_next <= max_q + "00000001" when ( max_q < m and x= '1' and y= '0') else
		max_q - "00000001" when (x= '0' and y= '1' and max_q > "00000000") else
		max_q;
					

-- Output logic
max_capacity <= '1' when max_q >= m else
		'0';	

end system; 
