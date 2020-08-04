LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_signed.ALL;

ENTITY alignExpo16bits IS
    GENERIC (n : INTEGER := 11);
    PORT (
        C_mantissa_expo_B : IN std_logic_vector(n - 1 DOWNTO 0);
        C_exponent_expo_A : IN std_logic_vector(4 DOWNTO 0);
        C_exponent_expo_B : IN std_logic_vector(4 DOWNTO 0);
        C_mantissa_expo_result : OUT std_logic_vector(n - 1 DOWNTO 0);
        C_exponent_expo_result : OUT std_logic_vector(4 DOWNTO 0);
        C_subtract : OUT std_logic_vector(5 DOWNTO 0)
    );
END alignExpo16bits;

ARCHITECTURE behavior OF alignExpo16bits IS
    SIGNAL subtract : std_logic_vector(5 DOWNTO 0);
    SIGNAL zeros : std_logic_vector(n - 1 DOWNTO 0);
    SIGNAL S_mantissa : std_logic_vector(n - 1 DOWNTO 0);
BEGIN
    zeros <= (OTHERS => '0');
    subtract <= (C_exponent_expo_B(4) & C_exponent_expo_B) - (C_exponent_expo_A(4) & C_exponent_expo_A) WHEN to_integer(unsigned(C_exponent_expo_A)) < to_integer(unsigned(C_exponent_expo_B)) ELSE
        (C_exponent_expo_A(4) & C_exponent_expo_A) - (C_exponent_expo_B(4) & C_exponent_expo_B);

    S_mantissa <= C_mantissa_expo_B;
    C_mantissa_expo_result <= S_mantissa WHEN subtract = "00000" ELSE
        zeros(0) & S_mantissa(n - 1 DOWNTO 1) WHEN subtract = "00001" ELSE
        zeros(1 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 2) WHEN subtract = "00010" ELSE
        zeros(2 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 3) WHEN subtract = "00011" ELSE
        zeros(3 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 4) WHEN subtract = "00100" ELSE
        zeros(4 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 5) WHEN subtract = "00101" ELSE
        zeros(5 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 6) WHEN subtract = "00110" ELSE
        zeros(6 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 7) WHEN subtract = "00111" ELSE
        zeros(7 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 8) WHEN subtract = "01000" ELSE
        zeros(8 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 9) WHEN subtract = "01001" ELSE
        zeros(9 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 10) WHEN subtract = "01001" ELSE
        zeros;

    C_exponent_expo_result <= C_exponent_expo_B WHEN to_integer(unsigned(C_exponent_expo_A)) < to_integer(unsigned(C_exponent_expo_B)) ELSE
        C_exponent_expo_A;

    C_subtract <= subtract;

END behavior;