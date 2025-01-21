library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity question3 is

port( sign_mag : in std_logic_vector(3 downto 0) ;
        twos_comp : out std_logic_vector(3 downto 0) );
end;


architecture structural of question3 is
begin

process (sign_mag)
variable number : std_logic_vector(3 downto 0);
variable answer : std_logic_vector(3 downto 0);
begin

number := sign_mag;

IF number(3) = '0' THEN
       	answer := number ;
ELSE
        answer := number(3)&( not number(2 downto 0)  + "001"  );

end IF;

twos_comp <= answer;

end process;



end structural;

