LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_signed.ALL;

ENTITY alignResult16bits IS
    GENERIC (n : INTEGER := 11);
    PORT (
        Clk : IN std_logic;
        Reset : IN std_logic;
        C_sign_result : IN std_logic;
        C_mantissa_result : IN std_logic_vector(n - 1 DOWNTO 0);
        C_exponent_result : IN std_logic_vector(4 DOWNTO 0);
        C_result : OUT std_logic_vector(15 DOWNTO 0)
    );
END alignResult16bits;

ARCHITECTURE behavior OF alignResult16bits IS
    SIGNAL S_sign_result : std_logic;
    SIGNAL S_mantissa_result : std_logic_vector(n - 1 DOWNTO 0);
    SIGNAL S_exponent_result : std_logic_vector(4 DOWNTO 0);
    SIGNAL S_result : std_logic_vector(15 DOWNTO 0);
    SIGNAL S_mantissa_res : std_logic_vector(n - 2 DOWNTO 0);
    SIGNAL S_exponent_res : unsigned(4 DOWNTO 0);
    SIGNAL S_sign : std_logic;
    SIGNAL zeros : std_logic_vector(n - 2 DOWNTO 0);
BEGIN
    zeros <= (OTHERS => '0');
    S_sign <= S_sign_result;

    S_mantissa_res <= S_mantissa_result(n - 2 DOWNTO 0) WHEN S_mantissa_result(n - 1) = '1' ELSE
        S_mantissa_result(n - 3 DOWNTO 0) & zeros(0) WHEN S_mantissa_result(n - 1 DOWNTO n - 2) = "01" ELSE
        S_mantissa_result(n - 4 DOWNTO 0) & zeros(1 DOWNTO 0) WHEN S_mantissa_result(n - 1 DOWNTO n - 3) = "001" ELSE
        S_mantissa_result(n - 5 DOWNTO 0) & zeros(2 DOWNTO 0) WHEN S_mantissa_result(n - 1 DOWNTO n - 4) = "0001" ELSE
        S_mantissa_result(n - 6 DOWNTO 0) & zeros(3 DOWNTO 0) WHEN S_mantissa_result(n - 1 DOWNTO n - 5) = "00001" ELSE
        S_mantissa_result(n - 7 DOWNTO 0) & zeros(4 DOWNTO 0) WHEN S_mantissa_result(n - 1 DOWNTO n - 6) = "000001" ELSE
        S_mantissa_result(n - 8 DOWNTO 0) & zeros(5 DOWNTO 0) WHEN S_mantissa_result(n - 1 DOWNTO n - 7) = "0000001" ELSE
        S_mantissa_result(n - 9 DOWNTO 0) & zeros(6 DOWNTO 0) WHEN S_mantissa_result(n - 1 DOWNTO n - 8) = "00000001" ELSE
        zeros;

        S_exponent_res <= unsigned(S_exponent_result) WHEN S_mantissa_result(n - 1) = '1' ELSE
        unsigned(S_exponent_result) - "00001" WHEN S_mantissa_result(n - 1 DOWNTO n - 2) = "01" ELSE
        unsigned(S_exponent_result) - "00010" WHEN S_mantissa_result(n - 1 DOWNTO n - 3) = "001" ELSE
        unsigned(S_exponent_result) - "00011" WHEN S_mantissa_result(n - 1 DOWNTO n - 4) = "0001" ELSE
        unsigned(S_exponent_result) - "00100" WHEN S_mantissa_result(n - 1 DOWNTO n - 5) = "00001" ELSE
        unsigned(S_exponent_result) - "00101" WHEN S_mantissa_result(n - 1 DOWNTO n - 6) = "000001" ELSE
        unsigned(S_exponent_result) - "00110" WHEN S_mantissa_result(n - 1 DOWNTO n - 7) = "0000001" ELSE
        unsigned(S_exponent_result) - "00111" WHEN S_mantissa_result(n - 1 DOWNTO n - 8) = "00000001" ELSE
        unsigned(S_exponent_result) - "01000" WHEN S_mantissa_result(n - 1 DOWNTO n - 9) = "000000001" ELSE
        "00000";

    S_result <= S_sign & std_logic_vector(S_exponent_res) & S_mantissa_res;
    PROCESS (Clk, reset)

    BEGIN
        IF (reset = '1') THEN
            S_sign_result <= '0';
            S_mantissa_result <= (OTHERS => '0');
            S_exponent_result <= (OTHERS => '0');
        ELSIF (Clk'event AND Clk = '1') THEN
            S_sign_result <= C_sign_result;
            S_mantissa_result <= C_mantissa_result;
            S_exponent_result <= C_exponent_result;
            
            C_result <= S_result;
            
        END IF;
    END PROCESS;
END behavior;