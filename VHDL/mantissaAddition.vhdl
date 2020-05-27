library ieee;
use ieee.std_logic_1164.all;

entity adder is 
    generic(n: integer:=23);
    port(cin: in std_logic;
         a, b: in std_logic_vector(n-1 downto 0);
         S: out std_logic_vector(n-1 downto 0);
         cout: out std_logic

    );
end;

architecture add of adder is 
    component fullAdder
        port(x,y,z: in std_logic;
             sum, carry: out std_logic
        );
    end component;
    signal t:std_logic_vector(n downto 0);
begin 
    t(0) <= cin;
    cout <= t(n);
    fa:for i in 1 to n-1 generate
        fai:fulladder port map (t(i), a(i), b(i), S(i), t(i+1));
    end generate;
end;