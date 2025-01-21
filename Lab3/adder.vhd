library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity adder is
port( input1 : in std_logic_vector(2 downto 0) ;
        output1 : out std_logic_vector(2 downto 0) );
end;

architecture structural of adder is
begin

output1 <= input1 + "001";

end structural;

