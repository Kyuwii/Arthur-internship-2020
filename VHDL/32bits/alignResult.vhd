LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_signed.ALL;

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
    SIGNAL S_mantissa_result : std_logic_vector(22 DOWNTO 0);
    SIGNAL S_mantissa_final_result : std_logic_vector(22 DOWNTO 0);
    SIGNAL S_exponent_result : unsigned(7 DOWNTO 0);
    SIGNAL S_sign : std_logic;
    SIGNAL zeros : std_logic_vector(22 DOWNTO 0);
    SIGNAL errors : std_logic_vector(22 DOWNTO 0);
    SIGNAL S_one : std_logic_vector(7 DOWNTO 0);
BEGIN
    zeros <= "00000000000000000000000";
    errors <= "11111111111111111111111";
    S_one <= "00000001";
    S_sign <= C_sign_result;

    S_mantissa_result <= C_mantissa_result WHEN C_mantissa_result(n - 1) = '1' ELSE
        C_mantissa_result(n - 2 DOWNTO 0) & zeros(0) WHEN C_mantissa_result(n - 1 DOWNTO n - 2) = "01" ELSE
        C_mantissa_result(n - 3 DOWNTO 0) & zeros(1 DOWNTO 0) WHEN C_mantissa_result(n - 1 DOWNTO n - 3) = "001" ELSE
        C_mantissa_result(n - 4 DOWNTO 0) & zeros(2 DOWNTO 0) WHEN C_mantissa_result(n - 1 DOWNTO n - 4) = "0001" ELSE
        C_mantissa_result(n - 5 DOWNTO 0) & zeros(3 DOWNTO 0) WHEN C_mantissa_result(n - 1 DOWNTO n - 5) = "00001" ELSE
        C_mantissa_result(n - 6 DOWNTO 0) & zeros(4 DOWNTO 0) WHEN C_mantissa_result(n - 1 DOWNTO n - 6) = "000001" ELSE
        C_mantissa_result(n - 7 DOWNTO 0) & zeros(5 DOWNTO 0) WHEN C_mantissa_result(n - 1 DOWNTO n - 7) = "0000001" ELSE
        C_mantissa_result(n - 8 DOWNTO 0) & zeros(6 DOWNTO 0) WHEN C_mantissa_result(n - 1 DOWNTO n - 8) = "00000001" ELSE
        C_mantissa_result(n - 9 DOWNTO 0) & zeros(7 DOWNTO 0) WHEN C_mantissa_result(n - 1 DOWNTO n - 9) = "000000001" ELSE
        C_mantissa_result(n - 10 DOWNTO 0) & zeros(8 DOWNTO 0) WHEN C_mantissa_result(n - 1 DOWNTO n - 10) = "0000000001" ELSE
        C_mantissa_result(n - 11 DOWNTO 0) & zeros(9 DOWNTO 0) WHEN C_mantissa_result(n - 1 DOWNTO n - 11) = "00000000001" ELSE
        C_mantissa_result(n - 12 DOWNTO 0) & zeros(10 DOWNTO 0) WHEN C_mantissa_result(n - 1 DOWNTO n - 12) = "000000000001" ELSE
        C_mantissa_result(n - 13 DOWNTO 0) & zeros(11 DOWNTO 0) WHEN C_mantissa_result(n - 1 DOWNTO n - 13) = "0000000000001" ELSE
        C_mantissa_result(n - 14 DOWNTO 0) & zeros(12 DOWNTO 0) WHEN C_mantissa_result(n - 1 DOWNTO n - 14) = "00000000000001" ELSE
        C_mantissa_result(n - 15 DOWNTO 0) & zeros(13 DOWNTO 0) WHEN C_mantissa_result(n - 1 DOWNTO n - 15) = "000000000000001" ELSE
        C_mantissa_result(n - 16 DOWNTO 0) & zeros(14 DOWNTO 0) WHEN C_mantissa_result(n - 1 DOWNTO n - 16) = "0000000000000001" ELSE
        C_mantissa_result(n - 17 DOWNTO 0) & zeros(15 DOWNTO 0) WHEN C_mantissa_result(n - 1 DOWNTO n - 17) = "00000000000000001" ELSE
        C_mantissa_result(n - 18 DOWNTO 0) & zeros(16 DOWNTO 0) WHEN C_mantissa_result(n - 1 DOWNTO n - 18) = "000000000000000001" ELSE
        C_mantissa_result(n - 19 DOWNTO 0) & zeros(17 DOWNTO 0) WHEN C_mantissa_result(n - 1 DOWNTO n - 19) = "0000000000000000001" ELSE
        C_mantissa_result(n - 20 DOWNTO 0) & zeros(18 DOWNTO 0) WHEN C_mantissa_result(n - 1 DOWNTO n - 20) = "00000000000000000001" ELSE
        C_mantissa_result(n - 21 DOWNTO 0) & zeros(19 DOWNTO 0) WHEN C_mantissa_result(n - 1 DOWNTO n - 21) = "000000000000000000001" ELSE
        C_mantissa_result(n - 22 DOWNTO 0) & zeros(20 DOWNTO 0) WHEN C_mantissa_result(n - 1 DOWNTO n - 22) = "0000000000000000000001" ELSE
        zeros;

    S_mantissa_final_result <= '0' & S_mantissa_result(n - 2 DOWNTO 0);

    S_exponent_result <= unsigned(C_exponent_result) WHEN C_mantissa_result(n - 1) = '1' ELSE 
        unsigned(C_exponent_result) - "00000001" WHEN C_mantissa_result(n - 1 DOWNTO n - 2) = "01" ELSE
        unsigned(C_exponent_result) - "00000010" WHEN C_mantissa_result(n - 1 DOWNTO n - 3) = "001" ELSE
        unsigned(C_exponent_result) - "00000011" WHEN C_mantissa_result(n - 1 DOWNTO n - 4) = "0001" ELSE
        unsigned(C_exponent_result) - "00000100" WHEN C_mantissa_result(n - 1 DOWNTO n - 5) = "00001" ELSE
        unsigned(C_exponent_result) - "00000101" WHEN C_mantissa_result(n - 1 DOWNTO n - 6) = "000001" ELSE
        unsigned(C_exponent_result) - "00000110" WHEN C_mantissa_result(n - 1 DOWNTO n - 7) = "0000001" ELSE
        unsigned(C_exponent_result) - "00000111" WHEN C_mantissa_result(n - 1 DOWNTO n - 8) = "00000001" ELSE
        unsigned(C_exponent_result) - "00001000" WHEN C_mantissa_result(n - 1 DOWNTO n - 9) = "000000001" ELSE
        unsigned(C_exponent_result) - "00001001" WHEN C_mantissa_result(n - 1 DOWNTO n - 10) = "0000000001" ELSE
        unsigned(C_exponent_result) - "00001010" WHEN C_mantissa_result(n - 1 DOWNTO n - 11) = "00000000001" ELSE
        unsigned(C_exponent_result) - "00001011" WHEN C_mantissa_result(n - 1 DOWNTO n - 12) = "000000000001" ELSE
        unsigned(C_exponent_result) - "00001100" WHEN C_mantissa_result(n - 1 DOWNTO n - 13) = "0000000000001" ELSE
        unsigned(C_exponent_result) - "00001101" WHEN C_mantissa_result(n - 1 DOWNTO n - 14) = "00000000000001" ELSE
        unsigned(C_exponent_result) - "00001110" WHEN C_mantissa_result(n - 1 DOWNTO n - 15) = "000000000000001" ELSE
        unsigned(C_exponent_result) - "00001111" WHEN C_mantissa_result(n - 1 DOWNTO n - 16) = "0000000000000001" ELSE
        unsigned(C_exponent_result) - "00010000" WHEN C_mantissa_result(n - 1 DOWNTO n - 17) = "00000000000000001" ELSE
        unsigned(C_exponent_result) - "00010001" WHEN C_mantissa_result(n - 1 DOWNTO n - 18) = "000000000000000001" ELSE
        unsigned(C_exponent_result) - "00010010" WHEN C_mantissa_result(n - 1 DOWNTO n - 19) = "0000000000000000001" ELSE
        unsigned(C_exponent_result) - "00010011" WHEN C_mantissa_result(n - 1 DOWNTO n - 20) = "00000000000000000001" ELSE
        unsigned(C_exponent_result) - "00010100" WHEN C_mantissa_result(n - 1 DOWNTO n - 21) = "000000000000000000001" ELSE
        unsigned(C_exponent_result) - "00010101" WHEN C_mantissa_result(n - 1 DOWNTO n - 22) = "0000000000000000000001" ELSE
        "00000000";
    
    C_result <= S_sign & std_logic_vector(S_exponent_result) & S_mantissa_final_result;
END behavior;