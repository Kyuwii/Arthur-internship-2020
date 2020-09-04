LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_signed.ALL;

ENTITY alignExpo IS
    GENERIC (n : INTEGER := 24);
    PORT (
        Clk : IN std_logic;
        Reset : IN std_logic;
        C_mantissa_expo_B : IN std_logic_vector(n - 1 DOWNTO 0);
        C_exponent_expo_A : IN std_logic_vector(7 DOWNTO 0);
        C_exponent_expo_B : IN std_logic_vector(7 DOWNTO 0);
        C_mantissa_expo_result : OUT std_logic_vector(n - 1 DOWNTO 0);
        C_exponent_expo_result : OUT std_logic_vector(7 DOWNTO 0);
        C_subtract : OUT std_logic_vector(8 DOWNTO 0)
    );
END alignExpo;

ARCHITECTURE behavior OF alignExpo IS
    SIGNAL S_mantissa_expo_B, S_mantissa_expo_result : std_logic_vector(n - 1 DOWNTO 0);
    SIGNAL S_exponent_expo_A, S_exponent_expo_B, S_exponent_expo_result : std_logic_vector(7 DOWNTO 0);
    SIGNAL S_subtract : std_logic_vector(8 DOWNTO 0);
    SIGNAL subtract : std_logic_vector(8 DOWNTO 0);
    SIGNAL zeros : std_logic_vector(n - 1 DOWNTO 0);
    SIGNAL S_mantissa : std_logic_vector(n - 1 DOWNTO 0);
BEGIN
    zeros <= "000000000000000000000000";
    subtract <= (S_exponent_expo_B(7) & S_exponent_expo_B) - (S_exponent_expo_A(7) & S_exponent_expo_A) WHEN to_integer(unsigned(S_exponent_expo_A)) < to_integer(unsigned(S_exponent_expo_B)) ELSE
        (S_exponent_expo_A(7) & S_exponent_expo_A) - (S_exponent_expo_B(7) & S_exponent_expo_B);

    S_mantissa <= S_mantissa_expo_B;
    S_mantissa_expo_result <= S_mantissa WHEN subtract = "000000000" ELSE
        zeros(0) & S_mantissa(n - 1 DOWNTO 1) WHEN subtract = "000000001" ELSE
        zeros(1 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 2) WHEN subtract = "000000010" ELSE
        zeros(2 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 3) WHEN subtract = "000000011" ELSE
        zeros(3 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 4) WHEN subtract = "000000100" ELSE
        zeros(4 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 5) WHEN subtract = "000000101" ELSE
        zeros(5 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 6) WHEN subtract = "000000110" ELSE
        zeros(6 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 7) WHEN subtract = "000000111" ELSE
        zeros(7 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 8) WHEN subtract = "000001000" ELSE
        zeros(8 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 9) WHEN subtract = "000001001" ELSE
        zeros(9 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 10) WHEN subtract = "000001010" ELSE
        zeros(10 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 11) WHEN subtract = "000001011" ELSE
        zeros(11 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 12) WHEN subtract = "000001100" ELSE
        zeros(12 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 13) WHEN subtract = "000001101" ELSE
        zeros(13 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 14) WHEN subtract = "000001110" ELSE
        zeros(14 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 15) WHEN subtract = "000001111" ELSE
        zeros(15 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 16) WHEN subtract = "000010000" ELSE
        zeros(16 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 17) WHEN subtract = "000100001" ELSE
        zeros(17 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 18) WHEN subtract = "000100010" ELSE
        zeros(18 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 19) WHEN subtract = "000100011" ELSE
        zeros(19 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 20) WHEN subtract = "000100100" ELSE
        zeros(20 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 21) WHEN subtract = "000100101" ELSE
        zeros(21 DOWNTO 0) & S_mantissa(n - 1 DOWNTO 22) WHEN subtract = "000100110" ELSE
        zeros(22 DOWNTO 0) & S_mantissa(n - 1) WHEN subtract = "00100111" ELSE
        zeros(23 DOWNTO 0);
    S_exponent_expo_result <= S_exponent_expo_B WHEN to_integer(unsigned(S_exponent_expo_A)) < to_integer(unsigned(S_exponent_expo_B)) ELSE
        S_exponent_expo_A;

    S_subtract <= subtract;

    PROCESS (Clk, reset)
       
    BEGIN
        IF (reset = '1') THEN
            S_exponent_expo_A <= (OTHERS => '0');
            S_exponent_expo_B <= (OTHERS => '0');
            S_mantissa_expo_B <= (OTHERS => '0');
        ELSIF (Clk'event AND Clk = '1') THEN
            S_exponent_expo_A <= C_exponent_expo_A;
            S_exponent_expo_B <= C_exponent_expo_B;
            S_mantissa_expo_B <= C_mantissa_expo_B;

            C_mantissa_expo_result <= S_mantissa_expo_result;
            C_exponent_expo_result <= S_exponent_expo_result;
            C_subtract <= S_subtract;
        END IF;
    END PROCESS;


END behavior;