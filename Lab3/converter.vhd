library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity converter is

port( sign_mag : in std_logic_vector(3 downto 0) ;
	twos_comp : out std_logic_vector(3 downto 0) );
end;


architecture structural of converter is
signal sign : std_logic;
signal mag : std_logic_vector(2 downto 0);
signal answer : std_logic_vector(3 downto 0);
begin

process (sign_mag, sign,mag,answer)
begin

sign <= sign_mag(3);
mag <= not sign_mag(2 downto 0);

IF sign = '0' THEN 
	answer <= sign_mag;
ELSE 
	answer <= sign & ( mag + "001"  );

end IF;

twos_comp <= answer;
end process;

end structural;
