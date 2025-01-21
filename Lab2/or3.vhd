library IEEE; 
use IEEE.std_logic_1164.all;

entity or_3input_gate  is
port( in_1, in_2, in_3: in std_logic;
      output : out std_logic);
end;


architecture equation of or_3input_gate is begin
  output <= in_1 or in_2 or in_3;
end;


