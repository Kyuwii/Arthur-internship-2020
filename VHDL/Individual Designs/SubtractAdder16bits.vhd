LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY subtractAdder16bits IS
    GENERIC (n : INTEGER := 11);
    PORT (
        Clk : IN std_logic;
        Reset : IN std_logic;
        C_mantissa_adder_A : IN std_logic_vector(n - 1 DOWNTO 0);
        C_mantissa_adder_B : IN std_logic_vector(n - 1 DOWNTO 0);
        C_mantissa_adder_result : OUT std_logic_vector(n - 1 DOWNTO 0)
    );
END subtractAdder16bits;

ARCHITECTURE behavior OF subtractAdder16bits IS
    SIGNAL S_mantissa_adder_A, S_mantissa_adder_B, S_mantissa_adder_result : std_logic_vector(n - 1 DOWNTO 0);
    SIGNAL S_mantissa_A : std_logic_vector(n - 1 DOWNTO 0);
    SIGNAL S_mantissa_B : std_logic_vector(n - 1 DOWNTO 0);
BEGIN
    S_mantissa_A <= S_mantissa_adder_A WHEN S_mantissa_adder_A > S_mantissa_adder_B ELSE
        S_mantissa_adder_B;

    S_mantissa_B <= S_mantissa_adder_B WHEN S_mantissa_adder_A > S_mantissa_adder_B ELSE
        S_mantissa_adder_A;

    S_mantissa_adder_result <= S_mantissa_A - S_mantissa_B;
    PROCESS (Clk, reset)

    BEGIN
        IF (reset = '1') THEN
            S_mantissa_adder_A <= (OTHERS => '0');
            S_mantissa_adder_B <= (OTHERS => '0');


        ELSIF (Clk'event AND Clk = '1') THEN
            S_mantissa_adder_A <= C_mantissa_adder_A;
            S_mantissa_adder_B <= C_mantissa_adder_B;

            C_mantissa_adder_result <= S_mantissa_adder_result;
        END IF;
    END PROCESS;

END behavior;