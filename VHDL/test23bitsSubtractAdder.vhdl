library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testSubtractAdder is
end testSubtractAdder;

architecture behavior of testSubtractAdder is
    component subtractAdder is 
    port(A: in std_logic_vector(22 downto 0);
         B: in std_logic_vector(22 downto 0);
         operation: in std_logic;
         result: out std_logic_vector(22 downto 0)
    );
    end component;
    signal A, B, result: std_logic_vector(22 downto 0);
    signal operation: std_logic;
begin
    op: subtractAdder port map(A => A, B => B, operation => operation, result => result);
    process
    begin
        operation <= '1'; 
        A <= std_logic_vector(to_signed(50, 23));
        B <= std_logic_vector(to_signed(20, 23));
        wait for 100 ns;
        operation <= '0';
        wait for 100 ns;
    end process;
end behavior;