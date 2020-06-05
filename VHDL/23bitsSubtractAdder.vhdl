library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity subtractAdder is 
generic(n: integer:=23);
    port(A: in std_logic_vector(n-1 downto 0);
         B: in std_logic_vector(n-1 downto 0);
         result: out std_logic_vector(n downto 0)
    );
end subtractAdder;

architecture behavior of subtractAdder is
    signal operation: std_logic:= A(n-1) xor B(n-1);
begin
    with operation select
    result <= std_logic_vector(signed(A) - signed(B)) when '0',
              std_logic_vector(signed(A) + signed(B)) when '1',
              (others => '0') when others;
end behavior; 

