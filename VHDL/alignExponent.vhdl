library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alignExpo is 
generic(n: integer:=23);
    port(A: in std_logic_vector(n-1 downto 0);
         B: in std_logic_vector(n-1 downto 0);
         C: in std_logic_vector(7 downto 0);
         D: in std_logic_vector(7 downto 0);
         N_B: out std_logic_vector(n-1 downto 0);
         N_D: out std_logic_vector(7 downto 0)
    );
end alignExpo;

architecture behavior of alignExpo is
    signal size: std_logic_vector(7 downto 0);
    signal one: std_logic_vector(7 downto 0):="00000001";
    signal j: integer:=0;
    signal g: integer:=0;
begin
    process
    begin
        size <= std_logic_vector(signed(C) - signed(D));
        j <= to_integer(unsigned(size));
        l_size: for i in 0 to j loop
            one <= std_logic_vector(signed(one) + signed(one));
            
            l_n: while g < n loop
                N_B((g + 1)mod n) <= B(g);
                g <= g+1;
            end loop l_n;
            
            N_B(0) <= '0';
        end loop l_size;
        N_D <= std_logic_vector(signed(D) + signed(one));
    end process;

end behavior; 