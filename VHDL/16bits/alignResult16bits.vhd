LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_signed.ALL;

ENTITY alignResult16bits IS
    GENERIC (n : INTEGER := 10);
    PORT (
        C_sign_result : IN std_logic;
        C_mantissa_result : IN std_logic_vector(9 DOWNTO 0);
        C_exponent_result : IN std_logic_vector(4 DOWNTO 0);
        C_result : OUT std_logic_vector(15 DOWNTO 0)
    );
END alignResult16bits;

ARCHITECTURE behavior OF alignResult16bits IS
    SIGNAL S_mantissa_result : std_logic_vector(9 DOWNTO 0);
    SIGNAL S_exponent_result : std_logic_vector(4 DOWNTO 0);
    SIGNAL zeros : std_logic_vector(9 DOWNTO 0);
BEGIN
    zeros <= "0000000000";
    S_mantissa_result <= C_mantissa_result WHEN C_mantissa_result(n - 1) = '1' ELSE
        C_mantissa_result(n - 9 DOWNTO 0) & zeros(n - 1 DOWNTO n - 8) WHEN C_mantissa_result(n - 1 DOWNTO n - 8) = zeros(n - 1 DOWNTO n - 8) ELSE
        C_mantissa_result(n - 8 DOWNTO 0) & zeros(n - 1 DOWNTO n - 7) WHEN C_mantissa_result(n - 1 DOWNTO n - 7) = zeros(n - 1 DOWNTO n - 7) ELSE
        C_mantissa_result(n - 7 DOWNTO 0) & zeros(n - 1 DOWNTO n - 6) WHEN C_mantissa_result(n - 1 DOWNTO n - 6) = zeros(n - 1 DOWNTO n - 6) ELSE
        C_mantissa_result(n - 6 DOWNTO 0) & zeros(n - 1 DOWNTO n - 5) WHEN C_mantissa_result(n - 1 DOWNTO n - 5) = zeros(n - 1 DOWNTO n - 5) ELSE
        C_mantissa_result(n - 5 DOWNTO 0) & zeros(n - 1 DOWNTO n - 4) WHEN C_mantissa_result(n - 1 DOWNTO n - 4) = zeros(n - 1 DOWNTO n - 4) ELSE
        C_mantissa_result(n - 4 DOWNTO 0) & zeros(n - 1 DOWNTO n - 3) WHEN C_mantissa_result(n - 1 DOWNTO n - 3) = zeros(n - 1 DOWNTO n - 3) ELSE
        C_mantissa_result(n - 3 DOWNTO 0) & zeros(n - 1 DOWNTO n - 2) WHEN C_mantissa_result(n - 1 DOWNTO n - 2) = zeros(n - 1 DOWNTO n - 2) ELSE
        C_mantissa_result(n - 2 DOWNTO 0) & zeros(n - 1) WHEN C_mantissa_result(n - 1) = '0' ELSE
        "0000000000";


    S_exponent_result <= C_exponent_result WHEN C_mantissa_result(n - 1) = '1' ELSE
        C_exponent_result + "01001" WHEN C_mantissa_result(n - 1 DOWNTO n - 9) = zeros(n - 1 DOWNTO n - 9) ELSE
        C_exponent_result + "01000" WHEN C_mantissa_result(n - 1 DOWNTO n - 8) = zeros(n - 1 DOWNTO n - 8) ELSE
        C_exponent_result + "00111" WHEN C_mantissa_result(n - 1 DOWNTO n - 7) = zeros(n - 1 DOWNTO n - 7) ELSE
        C_exponent_result + "00110" WHEN C_mantissa_result(n - 1 DOWNTO n - 6) = zeros(n - 1 DOWNTO n - 6) ELSE
        C_exponent_result + "00101" WHEN C_mantissa_result(n - 1 DOWNTO n - 5) = zeros(n - 1 DOWNTO n - 5) ELSE
        C_exponent_result + "00100" WHEN C_mantissa_result(n - 1 DOWNTO n - 4) = zeros(n - 1 DOWNTO n - 4) ELSE
        C_exponent_result + "00011" WHEN C_mantissa_result(n - 1 DOWNTO n - 3) = zeros(n - 1 DOWNTO n - 3) ELSE
        C_exponent_result + "00010" WHEN C_mantissa_result(n - 1 DOWNTO n - 2) = zeros(n - 1 DOWNTO n - 2) ELSE
        C_exponent_result + "00001" WHEN C_mantissa_result(n - 1) = '0' ELSE
        "00000";

    C_result <= C_sign_result & S_exponent_result & S_mantissa_result;

END behavior;