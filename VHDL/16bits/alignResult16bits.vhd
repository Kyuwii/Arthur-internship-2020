LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_signed.ALL;

ENTITY alignResult16bits IS
    GENERIC (n : INTEGER := 11);
    PORT (
        C_sign_result : IN std_logic;
        C_mantissa_result : IN std_logic_vector(n - 1 DOWNTO 0);
        C_exponent_result : IN std_logic_vector(4 DOWNTO 0);
        C_result : OUT std_logic_vector(15 DOWNTO 0)
    );
END alignResult16bits;

ARCHITECTURE behavior OF alignResult16bits IS
    SIGNAL S_mantissa_result : std_logic_vector(n - 2 DOWNTO 0);
    SIGNAL S_exponent_result : unsigned(4 DOWNTO 0);
    SIGNAL S_sign : std_logic;
    SIGNAL zeros : std_logic_vector(n - 2 DOWNTO 0);
BEGIN
    zeros <= (others => '0');
    S_sign <= C_sign_result;

    S_mantissa_result <= C_mantissa_result(n - 2 DOWNTO 0) WHEN C_mantissa_result(n - 1) = '1' ELSE
        C_mantissa_result(n - 3 DOWNTO 0) & zeros(0) WHEN C_mantissa_result(n - 1 DOWNTO n - 2) = "01" ELSE
        C_mantissa_result(n - 4 DOWNTO 0) & zeros(1 DOWNTO 0) WHEN C_mantissa_result(n - 1 DOWNTO n - 3) = "001" ELSE
        C_mantissa_result(n - 5 DOWNTO 0) & zeros(2 DOWNTO 0) WHEN C_mantissa_result(n - 1 DOWNTO n - 4) = "0001" ELSE
        C_mantissa_result(n - 6 DOWNTO 0) & zeros(3 DOWNTO 0) WHEN C_mantissa_result(n - 1 DOWNTO n - 5) = "00001" ELSE
        C_mantissa_result(n - 7 DOWNTO 0) & zeros(4 DOWNTO 0) WHEN C_mantissa_result(n - 1 DOWNTO n - 6) = "000001" ELSE
        C_mantissa_result(n - 8 DOWNTO 0) & zeros(5 DOWNTO 0) WHEN C_mantissa_result(n - 1 DOWNTO n - 7) = "0000001" ELSE
        C_mantissa_result(n - 9 DOWNTO 0) & zeros(6 DOWNTO 0) WHEN C_mantissa_result(n - 1 DOWNTO n - 8) = "00000001" ELSE
        zeros;

    S_exponent_result <= unsigned(C_exponent_result) WHEN C_mantissa_result(n - 1) = '1' ELSE 
        unsigned(C_exponent_result) - "00001" WHEN C_mantissa_result(n - 1 DOWNTO n - 2) = "01" ELSE
        unsigned(C_exponent_result) - "00010" WHEN C_mantissa_result(n - 1 DOWNTO n - 3) = "001" ELSE
        unsigned(C_exponent_result) - "00011" WHEN C_mantissa_result(n - 1 DOWNTO n - 4) = "0001" ELSE
        unsigned(C_exponent_result) - "00100" WHEN C_mantissa_result(n - 1 DOWNTO n - 5) = "00001" ELSE
        unsigned(C_exponent_result) - "00101" WHEN C_mantissa_result(n - 1 DOWNTO n - 6) = "000001" ELSE
        unsigned(C_exponent_result) - "00110" WHEN C_mantissa_result(n - 1 DOWNTO n - 7) = "0000001" ELSE
        unsigned(C_exponent_result) - "00111" WHEN C_mantissa_result(n - 1 DOWNTO n - 8) = "00000001" ELSE
        unsigned(C_exponent_result) - "01000" WHEN C_mantissa_result(n - 1 DOWNTO n - 9) = "000000001" ELSE
        "00000";
    
    C_result <= S_sign & std_logic_vector(S_exponent_result) & S_mantissa_result;
END behavior;