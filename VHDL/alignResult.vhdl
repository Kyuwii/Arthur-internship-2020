library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alignResult is 
generic(n: integer:=23);
    port(A: in std_logic;
         B: in std_logic_vector(n downto 0);
         C: in std_logic_vector(7 downto 0);
         RES: out std_logic_vector(n + 8 downto 0)
    );
end alignResult;

architecture behavior of alignResult is
   signal N_B: std_logic_vector(n-1 downto 0);
begin
    process
    begin
        N_B <= B(n-1 downto 0);

        l_size: for i in 0 to n loop
            if N_B(n-1) = '0' then
                N_B <= N_B(n-1 downto 0) & '0';
            end if;
        end loop l_size;
        RES <= A & C & N_B;
    end process;

end behavior; 
