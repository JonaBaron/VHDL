library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mux2_1 is
port( input1 : in std_logic_vector(2 downto 0) ;
	input0 : in std_logic_vector(2 downto 0) ;
	select1 :in std_logic ;
	output : out std_logic_vector(2 downto 0) );
end;

architecture structural of mux2_1 is
begin

process(input1 , input0, select1)
begin
IF select1 = '0' THEN
	output <= input0;
ELSE
	output <= input1;
end IF;
end process;

end structural;
 

