LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_signed.ALL;

ENTITY alignExpo IS
    GENERIC (n : INTEGER := 10);
    PORT (
        C_mantissa_expo_A : IN std_logic_vector(9 DOWNTO 0);
        C_mantissa_expo_B : IN std_logic_vector(9 DOWNTO 0);
        C_exponent_expo_A : IN std_logic_vector(4 DOWNTO 0);
        C_exponent_expo_B : IN std_logic_vector(4 DOWNTO 0);
        C_mantissa_expo_result : OUT std_logic_vector(9 DOWNTO 0);
        C_exponent_expo_result : OUT std_logic_vector(4 DOWNTO 0)
    );
END alignExpo;

ARCHITECTURE behavior OF alignExpo IS
    SIGNAL subtract : std_logic_vector(5 DOWNTO 0);
    SIGNAL zeros : std_logic_vector(9 DOWNTO 0);
    SIGNAL S_mantissa : std_logic_vector(9 DOWNTO 0);
BEGIN
    zeros <= "0000000000";

    subtract <= (C_exponent_expo_B(4) & C_exponent_expo_B) - (C_exponent_expo_A(4) & C_exponent_expo_A) WHEN to_integer(unsigned(C_exponent_expo_A)) < to_integer(unsigned(C_exponent_expo_B)) ELSE
        (C_exponent_expo_A(4) & C_exponent_expo_A) - (C_exponent_expo_B(4) & C_exponent_expo_B);

    S_mantissa <= C_mantissa_expo_A WHEN to_integer(unsigned(C_exponent_expo_A)) < to_integer(unsigned(C_exponent_expo_B)) ELSE
        C_mantissa_expo_B;
    

    C_mantissa_expo_result <= S_mantissa WHEN subtract = "00000000" ELSE
        zeros(0) & S_mantissa(n - 2 DOWNTO 0) WHEN subtract = "00000001" ELSE
        zeros(1 DOWNTO 0) & S_mantissa(n - 3 DOWNTO 0) WHEN subtract = "000000010" ELSE
        zeros(2 DOWNTO 0) & S_mantissa(n - 4 DOWNTO 0) WHEN subtract = "000000011" ELSE
        zeros(3 DOWNTO 0) & S_mantissa(n - 5 DOWNTO 0) WHEN subtract = "000000100" ELSE
        zeros(4 DOWNTO 0) & S_mantissa(n - 6 DOWNTO 0) WHEN subtract = "000000101" ELSE
        zeros(5 DOWNTO 0) & S_mantissa(n - 7 DOWNTO 0) WHEN subtract = "000000110" ELSE
        zeros(6 DOWNTO 0) & S_mantissa(n - 8 DOWNTO 0) WHEN subtract = "000000111" ELSE
        zeros(7 DOWNTO 0) & S_mantissa(n - 9 DOWNTO 0) WHEN subtract = "000001000" ELSE
        zeros(9 DOWNTO 0);

    C_exponent_expo_result <= C_exponent_expo_B WHEN to_integer(unsigned(C_exponent_expo_A)) < to_integer(unsigned(C_exponent_expo_B)) ELSE
        C_exponent_expo_A;

END behavior;