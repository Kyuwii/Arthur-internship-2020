LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY alignResult IS
    GENERIC (n : INTEGER := 23);
    PORT (
        C_sign_result : IN std_logic;
        C_mantissa_result : IN std_logic_vector(22 DOWNTO 0);
        C_exponent_result : IN std_logic_vector(7 DOWNTO 0);
        C_result : OUT std_logic_vector(31 DOWNTO 0)
    );
END alignResult;

ARCHITECTURE behavior OF alignResult IS
    SIGNAL S_B : std_logic_vector(n - 1 DOWNTO 0);
BEGIN
    PROCESS
    BEGIN
        S_B <= C_mantissa_result(n - 1 DOWNTO 0);

        l_size : FOR i IN 0 TO n LOOP
            IF S_B(n - 1) = '0' THEN
                S_B <= S_B(n - 2 DOWNTO 0) & '0';
            END IF;
        END LOOP l_size;
        C_result <= C_sign_result & C_exponent_result & S_B;
    END PROCESS;

END behavior;