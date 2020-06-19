LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY alignExpo IS
    GENERIC (n : INTEGER := 23);
    PORT (
        C_mantissa_expo_A : IN std_logic_vector(22 DOWNTO 0);
        C_mantissa_expo_B : IN std_logic_vector(22 DOWNTO 0);
        C_exponent_expo_A : IN std_logic_vector(7 DOWNTO 0);
        C_exponent_expo_B : IN std_logic_vector(7 DOWNTO 0);
        C_mantissa_expo_result : OUT std_logic_vector(22 DOWNTO 0);
        C_exponent_expo_result : OUT std_logic_vector(7 DOWNTO 0)
    );
END alignExpo;

ARCHITECTURE behavior OF alignExpo IS
    SIGNAL size : std_logic_vector(7 DOWNTO 0) := "00000000";
    SIGNAL one : std_logic_vector(7 DOWNTO 0) := "00000001";
    SIGNAL j : INTEGER := 0;
    SIGNAL g : INTEGER := 0;
BEGIN
    PROCESS
    BEGIN
        size <= std_logic_vector(signed(C_exponent_expo_A) - signed(C_exponent_expo_B));
        j <= to_integer(unsigned(size));
        l_size : FOR i IN 0 TO j LOOP
            one <= std_logic_vector(signed(one) + signed(one));

            l_n : WHILE g < n LOOP
                C_mantissa_expo_result((g + 1)MOD n) <= C_mantissa_expo_B(g);
                g <= g + 1;
            END LOOP l_n;

            C_mantissa_expo_result(0) <= '0';
        END LOOP l_size;
        C_exponent_expo_result <= std_logic_vector(signed(C_exponent_expo_B) + signed(one));
    END PROCESS;

END behavior;