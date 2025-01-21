library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity registers_min_max is
port( din: in std_logic_vector(3 downto 0);
	reset : in std_logic;
	clk: in std_logic;
	sel: in std_logic_vector(1 downto 0);
	max_out : out std_logic_vector(3 downto 0);
	min_out : out std_logic_vector(3 downto 0);
	reg_out : out std_logic_vector(3 downto 0));
end registers_min_max ;

---------------------------------------------------------
architecture logic of registers_min_max is
signal r0 : std_logic_vector(3 downto 0);
signal r1 : std_logic_vector(3 downto 0);
signal r2 : std_logic_vector(3 downto 0);
signal r3 : std_logic_vector(3 downto 0);
signal maxD : std_logic_vector(3 downto 0);
signal maxQ : std_logic_vector(3 downto 0);
signal minD : std_logic_vector(3 downto 0);
signal minQ : std_logic_vector(3 downto 0);
begin

shiftProcess : process (clk, reset)
begin
IF reset = '1' THEN
	r0 <= "1000";
	r1 <= "1000";
	r2 <= "1000";
	r3 <= "1000";

	ELSIF clk'event and clk = '1' then		
	r3 <= r2;
	r2 <= r1;
	r1 <= r0;
	r0 <= din;
end IF;
end process;

maxD <= r0 when (unsigned(r0) > unsigned(r1)) and (unsigned(r0) > unsigned(r2)) and (unsigned(r0) > unsigned(r3)) else
	r1 when (unsigned(r1) > unsigned(r2)) and (unsigned(r1) >unsigned(r3)) else
	r2 when (unsigned(r2) > unsigned(r3)) else
	r3;

minD <= r0 when (r0 <r1) and (r0 <r2) and (r0 <r3) else
	r1 when (r1 <r2) and (r1 <r3) else
	r2 when (r2 <r3) else
	r3;


minProcess : process (clk, reset)
begin
IF reset = '1' THEN
	minQ <= "1111";
ELSIF clk'event and clk = '1' then
	IF minQ > minD then
		min_out <= minD;
		minQ <= minD;
	end IF;	
end IF;
end process;

maxProcess : process (clk, reset)
begin
IF reset = '1' THEN
	maxQ <= "0000";
ELSIF clk'event and clk = '1' then
		IF maxD > maxQ then
			max_out <= maxD;
			maxQ <= maxD;
		end IF;	
end IF;
end process;

with sel select 
	reg_out <= r0 when "00",
		r1 when "01",
		r2 when "10",
		r3 when "11",
		"0000" when others;	

end;

