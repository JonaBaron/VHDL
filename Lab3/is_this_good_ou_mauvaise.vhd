library IEEE;
use IEEE.std_logic_1164.all;

entity question1 is 
port( mick : in std_logic;
	keith : out std_logic);
end;


architecture rtl of question1 is 

signal stone : std_logic;

begin

process(mick)
begin

stone <= mick and stone; 

end process;

keith <= stone;

end;

