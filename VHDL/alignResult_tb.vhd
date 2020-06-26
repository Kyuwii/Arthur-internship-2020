LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY alignResult_tb IS
END alignResult_tb;

ARCHITECTURE tb OF alignResult_tb IS

    COMPONENT alignResult
        GENERIC (n : INTEGER := 23);
        PORT (
            C_sign_result : IN std_logic;
            C_mantissa_result : IN std_logic_vector(22 DOWNTO 0);
            C_exponent_result : IN std_logic_vector(7 DOWNTO 0);
            C_result : OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL S_sign_result : std_logic;
    SIGNAL S_mantissa_result : std_logic_vector(22 DOWNTO 0);
    SIGNAL S_exponent_result : std_logic_vector(7 DOWNTO 0);
    SIGNAL S_result : std_logic_vector(31 DOWNTO 0);

BEGIN

    UTT : alignResult
    PORT MAP(
        C_sign_result => S_sign_result,
        C_mantissa_result => S_mantissa_result,
        C_exponent_result => S_exponent_result,
        C_result => S_result
    );

    TB : PROCESS
    BEGIN
        S_sign_result <= '0';
        S_mantissa_result <= "01001111111111111111111";
        S_exponent_result <= "10000001";

        WAIT FOR 20 ns;

        ASSERT(S_result = "01000001010011111111111111111110")
        REPORT "test failed" SEVERITY error;
    END PROCESS;
END tb;