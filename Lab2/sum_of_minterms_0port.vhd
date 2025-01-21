library ieee;
use ieee.std_logic_1164.all;

entity sum_of_minterms_0port is
  port(a,b,c : in std_logic;
       output : out std_logic);
end sum_of_minterms_0port;

architecture structural of sum_of_minterms_0port is

-- declare the different entity use as a componant

signal and_s1 , and_s2, and_s3 , invert_A , invert_B     : std_logic;

begin

-- not

invert_A <= not a;

invert_B <= not b;

-- and

and_s1 <= invert_A and  invert_B and c;

and_s2 <= invert_A and  b and c;

and_s3 <= a and  b and c;

-- Or

output <= and_s1 or and_s2 or and_s3;

end structural;
