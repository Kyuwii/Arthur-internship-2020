LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY alignExpo_tb IS
END alignExpo_tb;

ARCHITECTURE tb OF alignExpo_tb IS
    COMPONENT alignExpo
        PORT (
            C_mantissa_expo_A : IN std_logic_vector(22 DOWNTO 0);
            C_mantissa_expo_B : IN std_logic_vector(22 DOWNTO 0);
            C_exponent_expo_A : IN std_logic_vector(7 DOWNTO 0);
            C_exponent_expo_B : IN std_logic_vector(7 DOWNTO 0);
            C_mantissa_expo_result : OUT std_logic_vector(22 DOWNTO 0);
            C_exponent_expo_result : OUT std_logic_vector(7 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL S_mantissa_expo_A, S_mantissa_expo_B : std_logic_vector(22 DOWNTO 0);
    SIGNAL S_exponent_expo_A, S_exponent_expo_B : std_logic_vector(7 DOWNTO 0);
    SIGNAL S_mantissa_expo_result : std_logic_vector(22 DOWNTO 0);
    SIGNAL S_exponent_expo_result : std_logic_vector(7 DOWNTO 0);

BEGIN

    UTT : alignExpo
    PORT MAP(
        C_mantissa_expo_A <= S_mantissa_expo_A,
        C_mantissa_expo_B <= S_mantissa_expo_B,
        C_exponent_expo_A <= S_exponent_expo_A,
        C_exponent_expo_B <= S_exponent_expo_B,
        C_mantissa_expo_result <= S_mantissa_expo_result,
        C_exponent_expo_result <= S_exponent_expo_result 
    );

    TB : PROCESS
    BEGIN
        S_mantissa_expo_A <= (22 DOWNTO 8 => '1', OTHERS => '0');
        S_mantissa_expo_B <= (21 DOWNTO 10 => '0', OTHERS => '1');

        WAIT FOR 20 ns;

        S_exponent_expo_A <= "10000001";
        S_exponent_expo_B <= "10000001";

        ASSERT((S_mantissa_expo_result = "0110000000000000011111111") AND (S_exponent_expo_result = "1000001"))
        REPORT "test failed" SEVERITY error;
    END PROCESS;
END tb;