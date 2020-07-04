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
    SIGNAL S_exponent_result : std_logic_vector(7 DOWNTO 0);
    SIGNAL zeros : std_logic_vector(22 DOWNTO 0);
BEGIN
    zeros <= "00000000000000000000000";
    S_mantissa_result <= C_mantissa_result WHEN C_mantissa_result(n - 1) = '1' ELSE
        C_mantissa_result(n - 22 DOWNTO 0) & zeros(n - 1 DOWNTO n - 21) WHEN C_mantissa_result(n - 1 DOWNTO n - 21) = zeros(n - 1 DOWNTO n - 21) ELSE
        C_mantissa_result(n - 21 DOWNTO 0) & zeros(n - 1 DOWNTO n - 20) WHEN C_mantissa_result(n - 1 DOWNTO n - 20) = zeros(n - 1 DOWNTO n - 20) ELSE
        C_mantissa_result(n - 20 DOWNTO 0) & zeros(n - 1 DOWNTO n - 19) WHEN C_mantissa_result(n - 1 DOWNTO n - 19) = zeros(n - 1 DOWNTO n - 19) ELSE
        C_mantissa_result(n - 19 DOWNTO 0) & zeros(n - 1 DOWNTO n - 18) WHEN C_mantissa_result(n - 1 DOWNTO n - 18) = zeros(n - 1 DOWNTO n - 18) ELSE
        C_mantissa_result(n - 18 DOWNTO 0) & zeros(n - 1 DOWNTO n - 17) WHEN C_mantissa_result(n - 1 DOWNTO n - 17) = zeros(n - 1 DOWNTO n - 17) ELSE
        C_mantissa_result(n - 17 DOWNTO 0) & zeros(n - 1 DOWNTO n - 16) WHEN C_mantissa_result(n - 1 DOWNTO n - 16) = zeros(n - 1 DOWNTO n - 16) ELSE
        C_mantissa_result(n - 16 DOWNTO 0) & zeros(n - 1 DOWNTO n - 15) WHEN C_mantissa_result(n - 1 DOWNTO n - 15) = zeros(n - 1 DOWNTO n - 15) ELSE
        C_mantissa_result(n - 15 DOWNTO 0) & zeros(n - 1 DOWNTO n - 14) WHEN C_mantissa_result(n - 1 DOWNTO n - 14) = zeros(n - 1 DOWNTO n - 14) ELSE
        C_mantissa_result(n - 14 DOWNTO 0) & zeros(n - 1 DOWNTO n - 13) WHEN C_mantissa_result(n - 1 DOWNTO n - 13) = zeros(n - 1 DOWNTO n - 13) ELSE
        C_mantissa_result(n - 13 DOWNTO 0) & zeros(n - 1 DOWNTO n - 12) WHEN C_mantissa_result(n - 1 DOWNTO n - 12) = zeros(n - 1 DOWNTO n - 12) ELSE
        C_mantissa_result(n - 12 DOWNTO 0) & zeros(n - 1 DOWNTO n - 11) WHEN C_mantissa_result(n - 1 DOWNTO n - 11) = zeros(n - 1 DOWNTO n - 11) ELSE
        C_mantissa_result(n - 11 DOWNTO 0) & zeros(n - 1 DOWNTO n - 10) WHEN C_mantissa_result(n - 1 DOWNTO n - 10) = zeros(n - 1 DOWNTO n - 10) ELSE
        C_mantissa_result(n - 10 DOWNTO 0) & zeros(n - 1 DOWNTO n - 9) WHEN C_mantissa_result(n - 1 DOWNTO n - 9) = zeros(n - 1 DOWNTO n - 9) ELSE
        C_mantissa_result(n - 9 DOWNTO 0) & zeros(n - 1 DOWNTO n - 8) WHEN C_mantissa_result(n - 1 DOWNTO n - 8) = zeros(n - 1 DOWNTO n - 8) ELSE
        C_mantissa_result(n - 8 DOWNTO 0) & zeros(n - 1 DOWNTO n - 7) WHEN C_mantissa_result(n - 1 DOWNTO n - 7) = zeros(n - 1 DOWNTO n - 7) ELSE
        C_mantissa_result(n - 7 DOWNTO 0) & zeros(n - 1 DOWNTO n - 6) WHEN C_mantissa_result(n - 1 DOWNTO n - 6) = zeros(n - 1 DOWNTO n - 6) ELSE
        C_mantissa_result(n - 6 DOWNTO 0) & zeros(n - 1 DOWNTO n - 5) WHEN C_mantissa_result(n - 1 DOWNTO n - 5) = zeros(n - 1 DOWNTO n - 5) ELSE
        C_mantissa_result(n - 5 DOWNTO 0) & zeros(n - 1 DOWNTO n - 4) WHEN C_mantissa_result(n - 1 DOWNTO n - 4) = zeros(n - 1 DOWNTO n - 4) ELSE
        C_mantissa_result(n - 4 DOWNTO 0) & zeros(n - 1 DOWNTO n - 3) WHEN C_mantissa_result(n - 1 DOWNTO n - 3) = zeros(n - 1 DOWNTO n - 3) ELSE
        C_mantissa_result(n - 3 DOWNTO 0) & zeros(n - 1 DOWNTO n - 2) WHEN C_mantissa_result(n - 1 DOWNTO n - 2) = zeros(n - 1 DOWNTO n - 2) ELSE
        C_mantissa_result(n - 2 DOWNTO 0) & zeros(n - 1) WHEN C_mantissa_result(n - 1) = '0' ELSE
        "00000000000000000000000";


    S_exponent_result <= C_exponent_result WHEN C_mantissa_result(n - 1) = '1' ELSE
        C_exponent_result + "00010101" WHEN C_mantissa_result(n - 1 DOWNTO n - 21) = zeros(n - 1 DOWNTO n - 21) ELSE
        C_exponent_result + "00010100" WHEN C_mantissa_result(n - 1 DOWNTO n - 20) = zeros(n - 1 DOWNTO n - 20) ELSE
        C_exponent_result + "00010011" WHEN C_mantissa_result(n - 1 DOWNTO n - 19) = zeros(n - 1 DOWNTO n - 19) ELSE
        C_exponent_result + "00010010" WHEN C_mantissa_result(n - 1 DOWNTO n - 18) = zeros(n - 1 DOWNTO n - 18) ELSE
        C_exponent_result + "00010001" WHEN C_mantissa_result(n - 1 DOWNTO n - 17) = zeros(n - 1 DOWNTO n - 17) ELSE
        C_exponent_result + "00010000" WHEN C_mantissa_result(n - 1 DOWNTO n - 16) = zeros(n - 1 DOWNTO n - 16) ELSE
        C_exponent_result + "00001111" WHEN C_mantissa_result(n - 1 DOWNTO n - 15) = zeros(n - 1 DOWNTO n - 15) ELSE
        C_exponent_result + "00001110" WHEN C_mantissa_result(n - 1 DOWNTO n - 14) = zeros(n - 1 DOWNTO n - 14) ELSE
        C_exponent_result + "00001101" WHEN C_mantissa_result(n - 1 DOWNTO n - 13) = zeros(n - 1 DOWNTO n - 13) ELSE
        C_exponent_result + "00001100" WHEN C_mantissa_result(n - 1 DOWNTO n - 12) = zeros(n - 1 DOWNTO n - 12) ELSE
        C_exponent_result + "00001011" WHEN C_mantissa_result(n - 1 DOWNTO n - 11) = zeros(n - 1 DOWNTO n - 11) ELSE
        C_exponent_result + "00001010" WHEN C_mantissa_result(n - 1 DOWNTO n - 10) = zeros(n - 1 DOWNTO n - 10) ELSE
        C_exponent_result + "00001001" WHEN C_mantissa_result(n - 1 DOWNTO n - 9) = zeros(n - 1 DOWNTO n - 9) ELSE
        C_exponent_result + "00001000" WHEN C_mantissa_result(n - 1 DOWNTO n - 8) = zeros(n - 1 DOWNTO n - 8) ELSE
        C_exponent_result + "00000111" WHEN C_mantissa_result(n - 1 DOWNTO n - 7) = zeros(n - 1 DOWNTO n - 7) ELSE
        C_exponent_result + "00000110" WHEN C_mantissa_result(n - 1 DOWNTO n - 6) = zeros(n - 1 DOWNTO n - 6) ELSE
        C_exponent_result + "00000101" WHEN C_mantissa_result(n - 1 DOWNTO n - 5) = zeros(n - 1 DOWNTO n - 5) ELSE
        C_exponent_result + "00000100" WHEN C_mantissa_result(n - 1 DOWNTO n - 4) = zeros(n - 1 DOWNTO n - 4) ELSE
        C_exponent_result + "00000011" WHEN C_mantissa_result(n - 1 DOWNTO n - 3) = zeros(n - 1 DOWNTO n - 3) ELSE
        C_exponent_result + "00000010" WHEN C_mantissa_result(n - 1 DOWNTO n - 2) = zeros(n - 1 DOWNTO n - 2) ELSE
        C_exponent_result + "00000001" WHEN C_mantissa_result(n - 1) = '0' ELSE
        "00000000";

    C_result <= C_sign_result & S_exponent_result & S_mantissa_result;

END behavior;