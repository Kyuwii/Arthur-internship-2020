LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY subtractAdder_tb IS
END subtractAdder_tb;

ARCHITECTURE tb OF subtractAdder_tb IS
    COMPONENT subtractAdder
        GENERIC (n : INTEGER := 23);
        PORT (
            C_mantissa_adder_A : IN std_logic_vector(n - 1 DOWNTO 0);
            C_mantissa_adder_B : IN std_logic_vector(n - 1 DOWNTO 0);
            C_mantissa_adder_result : OUT std_logic_vector(n DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL S_mantissa_adder_A, S_mantissa_adder_B : std_logic_vector(22 DOWNTO 0);
    SIGNAL S_mantissa_adder_result : std_logic_vector(23 DOWNTO 0);

BEGIN

    UTT : subtractAdder
    PORT MAP(
        C_mantissa_adder_A => S_mantissa_adder_A,
        C_mantissa_adder_B => S_mantissa_adder_B,
        C_mantissa_adder_result => S_mantissa_adder_result
    );

    TB : PROCESS
    BEGIN
        S_mantissa_adder_A <= "10110100101011001011110";
        S_mantissa_adder_B <= "00110010111100001010100";
        
        WAIT FOR 20 ns;

        ASSERT(S_mantissa_adder_result = "011100111100111010110010")
        REPORT "test failed" SEVERITY error;
    END PROCESS;
END tb;
