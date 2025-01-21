library ieee;
use ieee.std_logic_1164.all;

entity sum_of_minterms is
  port(a,b,c : in std_logic;
       output : out std_logic);
end sum_of_minterms;

architecture structural of sum_of_minterms is

-- declare the or , and component

component or_3input_gate
  port ( in_1, in_2, in_3 :   in std_logic;
         output : out std_logic);
end component;

component and_3input_gate
  port ( in_1, in_2, in_3 :   in std_logic;
         output : out std_logic);
end component;

signal and_s1 , and_s2, and_s3 , invert_A , invert_B     : std_logic;
          
-- declare the different entity use as a componant

for a1, a2,a3 : and_3input_gate use entity WORK.and_3input_gate(equation);

for o1 : or_3input_gate use entity WORK.or_3input_gate(equation);

begin

-- not

invert_A <= not a;

invert_B <= not b;

-- and

a1: and_3input_gate port map(in_1 => invert_A, in_2 => invert_B,
                         in_3 => c, output => and_s1);

a2: and_3input_gate port map(in_1 => invert_A, in_2 => b,
                         in_3 => c, output => and_s2);

a3: and_3input_gate port map(in_1 => a, in_2 => b,
                         in_3 => c, output => and_s3);
-- Or

o1: or_3input_gate port map(in_1 => and_s1, in_2 =>and_s2,
                         in_3 => and_s3, output => output);

end structural;
