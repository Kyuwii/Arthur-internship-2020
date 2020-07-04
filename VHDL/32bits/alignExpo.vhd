LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_signed.ALL;

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
    SIGNAL one : std_logic_vector(7 DOWNTO 0);
    SIGNAL subtract : std_logic_vector(8 DOWNTO 0);
    SIGNAL zeros : std_logic_vector(22 DOWNTO 0);
    SIGNAL S_mantissa : std_logic_vector(22 DOWNTO 0);
BEGIN
    zeros <= "00000000000000000000000";
    one <= "00000001";

    subtract <= (C_exponent_expo_B(7) & C_exponent_expo_B) - (C_exponent_expo_A(7) & C_exponent_expo_A) WHEN to_integer(unsigned(C_exponent_expo_A)) < to_integer(unsigned(C_exponent_expo_B)) ELSE
        (C_exponent_expo_A(7) & C_exponent_expo_A) - (C_exponent_expo_B(7) & C_exponent_expo_B);

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
        zeros(8 DOWNTO 0) & S_mantissa(n - 10 DOWNTO 0) WHEN subtract = "000001001" ELSE
        zeros(9 DOWNTO 0) & S_mantissa(n - 11 DOWNTO 0) WHEN subtract = "000001010" ELSE
        zeros(10 DOWNTO 0) & S_mantissa(n - 12 DOWNTO 0) WHEN subtract = "000001011" ELSE
        zeros(11 DOWNTO 0) & S_mantissa(n - 13 DOWNTO 0) WHEN subtract = "000001100" ELSE
        zeros(12 DOWNTO 0) & S_mantissa(n - 14 DOWNTO 0) WHEN subtract = "000001101" ELSE
        zeros(13 DOWNTO 0) & S_mantissa(n - 15 DOWNTO 0) WHEN subtract = "000001110" ELSE
        zeros(14 DOWNTO 0) & S_mantissa(n - 16 DOWNTO 0) WHEN subtract = "000001111" ELSE
        zeros(15 DOWNTO 0) & S_mantissa(n - 17 DOWNTO 0) WHEN subtract = "000010000" ELSE
        zeros(16 DOWNTO 0) & S_mantissa(n - 18 DOWNTO 0) WHEN subtract = "000100001" ELSE
        zeros(17 DOWNTO 0) & S_mantissa(n - 19 DOWNTO 0) WHEN subtract = "000100010" ELSE
        zeros(18 DOWNTO 0) & S_mantissa(n - 20 DOWNTO 0) WHEN subtract = "000100011" ELSE
        zeros(19 DOWNTO 0) & S_mantissa(n - 21 DOWNTO 0) WHEN subtract = "000100100" ELSE
        zeros(20 DOWNTO 0) & S_mantissa(n - 22 DOWNTO 0) WHEN subtract = "000100101" ELSE
        zeros(22 DOWNTO 0);

    C_exponent_expo_result <= C_exponent_expo_B WHEN to_integer(unsigned(C_exponent_expo_A)) < to_integer(unsigned(C_exponent_expo_B)) ELSE
        C_exponent_expo_A;

END behavior;